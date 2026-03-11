class TagsController < ApplicationController
  before_action :set_tag, only: %i[ show edit update destroy ]

  def index
    authorize! :read, Tag
    @title = "Etiquetas"
    @tags = Tag.includes(:credentials, :company).accessible_by(current_ability)
    @query = Tag.ransack
  end

  def ransack
    @query = Tag.ransack(params[:q])
    @tags = @query.result.order(:name).paginate(page: params[:page], per_page: 15)

    render turbo_stream: turbo_stream.replace(
      "tags-index",
      partial: "tags/index"
    )
  end


  def show
    authorize! :read, @tag
    @title = "Etiqueta"
  end

  def new
    authorize! :create, Tag
    @title = "Nueva etiqueta"
    @tag = Tag.new
  end

  def edit
    authorize! :update, @tag
    @title = "Editar etiqueta"
  end

  def create
    @tag = Tag.new(tag_params)

    authorize! :create, @tag

    respond_to do |format|
      if @tag.save
        format.html { redirect_to tags_path, notice: "Etiqueta creada" }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :update, @tag

    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to tags_path, notice: "Etiqueta actualizada", status: :see_other }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tag.destroy!

    respond_to do |format|
      format.html { redirect_to tags_path, notice: "Etiqueta eliminada", status: :see_other }
      format.json { head :no_content }
    end
  end


  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :color, :company_id)
  end
end
