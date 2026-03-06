class WebCompaniesController < ApplicationController
  before_action :set_web_company, only: %i[ show edit update destroy ]

  def index
    @title = "Webs"
    @web_companies = WebCompany.includes(:webs)
  end

  def show
    @title = "Web"
  end

  def new
    @title = "Nueva web"
    @web_company = WebCompany.new
  end

  def edit
    @title = "Editar web"
  end

  def create
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
