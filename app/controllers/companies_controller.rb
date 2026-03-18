class CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show edit update destroy ]

  def index
    authorize! :read, Company
    @title = "Clientes"

    @search = params[:q].nil? ? "" : params[:q][:name_or_legal_name_cont]
    @query = Company.ransack(params[:q])

    @companies = @query.result
      .accessible_by(current_ability)
      .includes(:subscription, :creator, :manager)
      .order(:name)
      .paginate(page: params[:page] || 1, per_page: params[:per_page] || 15)
  end

  def show
    @title = "Cliente"
  end

  def new
    @title = "Nueva cliente"
    @company = Company.new
    @company.build_manager
  end

  def edit
    @title = "Editar cliente"
  end

  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: "Cliente creado" }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @company.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, status: :see_other, notice: "Cliente actualizado" }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @company.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @company.destroy!

    respond_to do |format|
      format.html { redirect_to companies_path, status: :see_other, notice: "Cliente eliminado" }
      format.json { head :no_content }
    end
  end


  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params
      .require(:company)
      .permit(
        :subscription_id,
        :name,
        :legal_name,
        :tax_id,
        :address,
        :cp,
        :logo,
        :manager_id,
        :creator_id,
        :status,
        manager_attributes: [:id, :role, :name, :lastname, :email, :nif, :phone],
      )
  end
end
