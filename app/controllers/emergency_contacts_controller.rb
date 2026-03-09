class EmergencyContactsController < ApplicationController
  before_action :set_emergency_contact, only: %i[ edit update destroy ]

  def index
    authorize! :read, EmergencyContact
    @emergency_contacts = EmergencyContact.all
  end

  def new
    authorize! :create, EmergencyContact

    @title = "Nuevo contacto de emergencia"
    @emergency_contact = EmergencyContact.new(owner_user_id: params[:owner_user_id])
  end

  def edit
    @title = "Editar contacto de emergencia"
  end

  def create
    @emergency_contact = EmergencyContact.new(emergency_contact_params)

    authorize! :create, @emergency_contact

    respond_to do |format|
      if @emergency_contact.save
        format.html { redirect_to show_user_path(@emergency_contact.owner_user), notice: "Contacto de emergencia creado" }
        format.json { render :show, status: :created, location: @emergency_contact }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @emergency_contact.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @emergency_contact.update(emergency_contact_params)
        format.html { redirect_to @emergency_contact, notice: "Contacto de emergencia actualizado", status: :see_other }
        format.json { render :show, status: :ok, location: @emergency_contact }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @emergency_contact.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @emergency_contact.destroy!

    respond_to do |format|
      format.html { redirect_to emergency_contacts_path, notice: "Contacto de emergencia eliminado", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_emergency_contact
      @emergency_contact = EmergencyContact.find(params[:id])
    end

    def emergency_contact_params
      params.require(:emergency_contact).permit(:owner_user_id, :contact_user_id, :company_id, :status, :wait_days, :encrypted_payload, :crypto_version)
    end
end
