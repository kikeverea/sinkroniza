class CredentialsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[ api_change_credential_password ]
  before_action :set_credential, only: %i[ show edit update destroy api_credential api_change_credential_password ]


  def index
    authorize! :read, Credential
    @title = "Credenciales"
    @credentials = Credential.includes(:company, :web, :group, :tags).order(:name)
  end

  def show
    authorize! :read, @credential
    @title = "Credencial"
  end

  def new
    authorize! :create, Credential
    @title = "Nueva credencial"
    @credential = Credential.new
  end

  def edit
    authorize! :update, @credential
    @title = "Editar credencial"
  end

  def create
    authorize! :create, Credential

    @credential = Credential.new(credential_params)

    respond_to do |format|
      if @credential.save
        format.html { redirect_to @credential, notice: "Credential was successfully created." }
        format.json { render :show, status: :created, location: @credential }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @credential.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    authorize! :update, @credential

    respond_to do |format|
      if @credential.update(credential_params)
        format.html { redirect_to @credential, notice: "Credential was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @credential }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @credential.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @credential.destroy!

    respond_to do |format|
      format.html { redirect_to credentials_path, notice: "Credential was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end


  ## API
  def api_credentials
    render json: current_user.credentials.where(visible_extension: true)
  end

  def api_credential
    render json: @credential
  end

  def api_create
    @credential = Credential.new(credential_params)
    @credential.group_id ||= current_user.personal_group.id

    if @credential.save
      render json: @credential, status: :created
    else
      render json: { created: false }, status: :unprocessable_content
    end
  end

  def api_change_password
    password_param = params.require(:credential).permit(:password)

    if @credential.update(encrypted_blob: password_param[:password])
      render json: { updated: true }, status: :ok
    else
      render json: { updated: false }, status: :unprocessable_content
    end
  end

  private

  def set_credential
    @credential = Credential.find(params[:id])
  end

  def credential_params
    params
      .require(:credential)
      .permit(
        :group_id,
        :company_id,
        :web_id,
        :tags_ids,
        :credential_type,
        :web_company_type,
        :name,
        :description,
        :admin_description,
        :encrypted_blob,
        :mediator_code,
        :priority,
        :owner,
        :visible_extension,
        :active,
        :credential_type
      )
  end
end
