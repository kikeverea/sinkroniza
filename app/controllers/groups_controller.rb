class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]

  def index
    @title = "Grupos"
    @groups = Group.includes(:company)
  end

  def show
    @title = "Grupo"
  end

  def new
    @title = "Nuevo grupo"
    @group = Group.new
  end

  def edit
    @title = "Editar grupo"
  end

  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @group.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: "Group was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @group.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @group.destroy!

    respond_to do |format|
      format.html { redirect_to groups_path, notice: "Group was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end


  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:company_id, :name, :description, :created_by_user_id, :group_type)
  end
end
