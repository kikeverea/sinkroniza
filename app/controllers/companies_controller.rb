class CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show edit update destroy ]

  def index
    @title = "Compañías"
    @companies = Company.all
  end

  def show
    @title = "Compañía"
  end

  def new
    @title = "Nueva compañía"
    @company = Company.new
  end

  def edit
    @title = "Editar compañía"
  end

  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save!
        format.html { redirect_to @company, notice: "Compañía creada" }
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
        format.html { redirect_to @company, notice: "Compañía actualizada", status: :see_other }
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
      format.html { redirect_to companies_path, notice: "Compañía eliminada", status: :see_other }
      format.json { head :no_content }
    end
  end


  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:subscription_id, :name, :legal_name, :tax_id, :address, :cp, :logo, :manager_name, :manager_lastname, :manager_email, :manager_nif, :manager_phone, :active, :creator_user_id, :creator_user_name, :status)
  end
end
