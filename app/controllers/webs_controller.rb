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
    @web = Web.new(web_company_id: params[:web_company_id])

    render "components/turbo_modal_content", locals: { channel: :web, partial: "webs/form" }
  end

  def edit
    @title = "Editar web"
    render "components/turbo_modal_content", locals: { channel: :web, partial: "webs/form" }
  end

  def create
    @web = Web.new(web_params)

    respond_to do |format|
      if @web.save
        format.html { redirect_to @web.web_company, notice: "Web creada." }
        format.json { render :show, status: :created, location: @web }
      else
        format.turbo_stream { render "components/turbo_modal_content", locals: { channel: :web, partial: "webs/form" } }
        format.json { render json: @web.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @web.update(web_params)
        format.html { redirect_to @web.web_company, notice: "Web actualizada.", status: :see_other }
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

  def scrape_web
    @web = params[:web_id].present? ? Web.find(params[:web_id]) : Web.new(web_params)

    if @web.valid?
      scrape = WebScraper.scrape(web_params[:access_url])

      if scrape[:favicon].present?
        file = URI.open(scrape[:favicon])

        file.define_singleton_method(:original_filename) do
          File.basename(base_uri.path.presence || "favicon.ico")
        end

        @web.update(favicon: file)
      end

      @scrape_result = scrape.reduce([]) do |result, (key, value)|
        result << "#{I18n.t("activerecord.attributes.user.#{key}")}: No se ha encontrado" if value.blank?
        result
      end
    end

    render "components/turbo_modal_content", locals: { channel: :web, partial: "webs/form" }
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
        :favicon,
        :access_url,
        :active,
        :creator_user_id,
        :creator_user_name,
        :status,
        :send_button_id,
        :username_input_id,
        :password_input_id,
        tag_ids: []
      )
  end
end
