class WebsController < ApplicationController
  before_action :set_web, only: %i[ show edit update destroy ]

  def index
    @title = "Webs"
    @webs = Web.includes(:company)
  end

  def show
    @title = "Web"
  end

  def new
    @title = "Nueva web"
    @web = Web.new(web_company: WebCompany.find(params[:web_company_id]))
  end

  def edit
    @title = "Editar web"
  end

  def create
    @web = Web.new(web_params)

    respond_to do |format|
      if @web.save!
        format.html { redirect_to @web, notice: "Web creada." }
        format.json { render :show, status: :created, location: @web }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @web.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @web.update!(web_params)
        format.html { redirect_to @web, notice: "Web actualizada.", status: :see_other }
        format.json { render :show, status: :ok, location: @web }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @web.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @web.destroy!

    respond_to do |format|
      format.html { redirect_to webs_path, notice: "Web eliminada.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_web
      @web = Web.find(params[:id])
    end

    def web_params
      params
        .require(:web)
        .permit(
          :web_company_id,
          :web_company_type,
          :name,
          :alias,
          :logo,
          :access_url,
          :active,
          :creator_user_id,
          :creator_user_name,
          :status,
          tag_ids: []
        )
    end
end
