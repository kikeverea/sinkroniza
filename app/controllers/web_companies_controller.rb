class WebCompaniesController < ApplicationController
  before_action :set_web_company, only: %i[ show edit update destroy ]

  def index
    authorize! :read, WebCompany
    @title = "Compañías Web"
    @web_companies = WebCompany.accessible_by(current_ability).includes(:webs)
  end

  def show
    authorize! :read, @web_company
    @title = "Compañía Web"
  end

  def new
    authorize! :create, WebCompany
    @title = "Nueva compañía web"
    @web_company = WebCompany.new
  end

  def edit
    authorize! :update, @web_company
    @title = "Editar compañía web"
  end

  def create
    authorize! :create, WebCompany
    @web_company = WebCompany.new(web_company_params)

    respond_to do |format|
      if @web_company.save
        format.html { redirect_to @web_company, notice: "Compañía web creada" }
        format.json { render :show, status: :created, location: @web_company }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @web_company.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    authorize! :update, @web_company
    respond_to do |format|
      if @web_company.update(web_company_params)
        format.html { redirect_to @web_company, notice: "Compañía web actualizada", status: :see_other }
        format.json { render :show, status: :ok, location: @web_company }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @web_company.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    authorize! :destroy, @web_company

    @web_company.destroy!

    respond_to do |format|
      format.html { redirect_to web_companies_path, notice: "Compañía web eliminada", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_web_company
      @web_company = WebCompany.find(params[:id])
    end

    def web_company_params
      params.require(:web_company).permit(:name, :logo, :web_company_type)
    end
end
