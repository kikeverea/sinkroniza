class UsersController < ApplicationController
  include Toast

  before_action :set_target
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    authorize! :read, User
    @title = "Lista de usuarios"

    @search = params[:q].nil? ? "" : params[:q][:email_or_name_cont]

    @q = User.includes(:company).ransack(params[:q])

    result = @q.result.accessible_by(current_ability)

    @users = (@target.nil? || @target == "users") ? result.kept : User.kept
    @discarded_users = @target == "discarded" ? result.discarded : User.discarded

    @users = @users.order(:role, :name, :lastname).paginate(page: params[:page] || 1, per_page: params[:per_page] || 15)
    @discarded_users = @discarded_users.order(:role, :name, :lastname).paginate(page: params[:page] || 1, per_page: params[:per_page] || 15)
  end

  def show
    authorize! :read, @user
    @title = "Detalle de usuario"
  end

  def new
    authorize! :create, User
    @title = "Nuevo usuario"
    @target = :company if params[:company_id]
    @user = User.new(company_id: params[:company_id])
  end

  def edit
    authorize! :update, @user
    @title = "Editando usuario"
  end

  def create
    authorize! :create, User

    @user = User.new(user_params)
    @user.skip_password_validation = true

    return toast("Límite de usuarios excedido", :error) unless @user.company_id.nil? || @user.company.can_add_user?

    if @user.save
      redirect_to params[:target] == "company" ? @user.company : users_path, notice: "Usuario creado"
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    authorize! :update, @user

    filtered_params = user_params[:password].present? ?
      user_params :
      user_params.except(:password, :password_confirmation)

    if @user.update!(filtered_params)
      redirect_to params[:target] == "company" ? @user.company : show_user_path(@user), notice: "Usuario actualizado"
    else
      render :edit, notice: "Error al actualizar el usuario"
    end
  end

  def destroy
    authorize! :destroy, @user

    if @user.status == "deleted"
      @user.destroy!
    else
      @user.update!(status: :deleted)
    end

    redirect_to params[:target] == "company" ? @user.company : users_path, notice: "Usuario eliminado"
  end

  def logout
    sign_out current_user
    redirect_to root_path
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_target
    @target = params[:target]&.to_sym
  end

  def user_params
    params
      .require(:user)
      .permit(
        :role,
        :name,
        :lastname,
        :nif,
        :date_expiration_password,
        :status,
        :company_id,
        :group_id,
        :email,
        :phone,
        :password
      )
  end
end
