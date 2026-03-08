class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    authorize! :read, User
    @title = "Lista de usuarios"

    @search = params[:q].nil? ? "" : params[:q][:email_or_name_cont]
    @target = params[:target]

    @q = User.includes(:company).ransack(params[:q])

    result = @q.result

    @users = (@target.nil? || @target == "users") ? result.kept : User.kept
    @discarded_users = @target == "discarded" ? result.discarded : User.discarded

    @users = @users.order(created_at: :desc).paginate(:page => params[:page], :per_page => 15)
    @discarded_users = @discarded_users.order(created_at: :desc).paginate(:page => params[:page], :per_page => 15)
  end

  def show
    authorize! :read, @user
    @title = "Detalle de usuario"
  end

  def new
    authorize! :create, User
    @title = "Nuevo usuario"
    @user = User.new
  end

  def edit
    authorize! :update, @user
    @title = "Editando usuario"
  end

  def create
    authorize! :create, User
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "Usuario creado correctamente"
    else
      render :new
    end
  end

  def update
    authorize! :update, @user

    filtered_params = user_params[:password].present? ?
      user_params :
      user_params.except(:password, :password_confirmation)

    if @user.update!(filtered_params)
      redirect_to show_user_path(@user), notice: "Usuario actualizado correctamente"
    else
      render :edit, notice: "Error al actualizar el usuario"
    end
  end

  def destroy
    authorize! :destroy, @user
    @user.update!(status: :deleted)

    redirect_to users_path, notice: "Usuario eliminado correctamente"
  end

  def logout
    sign_out current_user
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params
      .require(:user)
      .permit(:role, :name, :lastname, :nif, :date_expiration_password, :status, :company_id, :email, :password)
  end
end
