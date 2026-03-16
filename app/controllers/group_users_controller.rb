class GroupUsersController < ApplicationController
  before_action :set_group_user, only: %i[ edit update destroy ]
  before_action :set_group, only: %i[ new edit create update ]
  before_action :set_available_users, only: %i[ new edit create update ]

  def index
    @group_users = GroupUser.includes(:user)
  end

  def new
    @title = "Añadir usuario a grupo"
    @group_user = GroupUser.new(group_id:params[:group_id])

    render "components/turbo_modal_content", locals: { channel: :group_user, partial: "group_users/form" }
  end

  def edit
    @title = "Editar usuario de grupo"
  end

  def create
    @group_user = GroupUser.new(group_user_params)

    respond_to do |format|
      if @group_user.save
        format.html { redirect_to @group_user.group, notice: "Usuario añadido" }
        format.json { render :show, status: :created, location: @group_user }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @group_user.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @group_user.update(group_user_params)
        format.html { redirect_to @group_user.group, notice: "Usuario de grupo actualizado" }
        format.json { render :show, status: :ok, location: @group_user }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @group_user.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @group_user.destroy!

    respond_to do |format|
      format.html { redirect_to @group_user.group, notice: "Usuario eliminado del grupo" }
      format.json { head :no_content }
    end
  end


  private

  def set_group_user
    @group_user = GroupUser.find(params[:id])
  end

  def set_group
    if @group_user
      @group = @group_user.group
    else
      @group = Group.find(params[:group_id] || params[:group_user][:group_id])
    end
  end

  def set_available_users
    @available_users = User
      .accessible_by(current_ability)
      .where(role: :user)
      .where.not(id: @group.user_ids)
      .order(:name, :lastname)
  end

  def group_user_params
    params.require(:group_user).permit(:group_id, :user_id, :encrypted_group_key, :crypto_version, :group_type, :role)
  end
end
