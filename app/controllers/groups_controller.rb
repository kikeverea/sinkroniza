class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]

  def index
    authorize! :read, Group
    @title = "Grupos"
    @groups = Group.accessible_by(current_ability).where(group_type: :company).includes(:company, group_users: :user)
  end

  def show
    authorize! :read, @group
    @title = "Grupo"
  end

  def new
    authorize! :create, Group
    @title = "Nuevo grupo"
    @group = Group.new
  end

  def edit
    authorize! :update, @group
    @title = "Editar grupo"
  end

  def create
    authorize! :create, Group

    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: "Grupo creado" }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @group.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    authorize! :update, @group

    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: "Grupo actualizado", status: :see_other }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @group.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    authorize! :destroy, @group

    @group.destroy!

    respond_to do |format|
      format.html { redirect_to groups_path, notice: "Grupo eliminado", status: :see_other }
      format.json { head :no_content }
    end
  end


  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:company_id, :name, :owner_id, :description, :creator_id, :group_type)
  end
end
