class FoldersController < ApplicationController
  before_action :set_folder, only: %i[ show edit update destroy ]

  def index
    @title = "Carpetas"
    @folders = Folder.parents.includes(:child_folders)
  end

  def show
    @title = "Carpeta"
  end

  def by_name
    @title = "Carpeta"
    @folder = Folder.find_by(name: params[:name])
    render :show
  end

  def new
    @title = "Nueva carpeta"
    @folder = Folder.new(parent_folder_id:params[:parent_folder_id])
  end

  def edit
    @title = "Editar carpeta"
  end

  def create
    @folder = Folder.new(folder_params)

    respond_to do |format|
      if @folder.save!
        format.html { redirect_to @folder, notice: "Carpeta creada" }
        format.json { render :show, status: :created, location: @folder }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @folder.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to @folder, notice: "Carpeta actualizada" }
        format.json { render :show, status: :ok, location: @folder }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @folder.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @folder.destroy!

    respond_to do |format|
      format.html { redirect_to folders_path, notice: "Carpeta eliminada" }
      format.json { head :no_content }
    end
  end


  private

  def set_folder
    @folder = Folder.find(params[:id])
  end

  def folder_params
    params.require(:folder).permit(:name, :company_id, :parent_folder_id)
  end
end
