class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    authorize! :read, User
    @title = "Lista de usuarios"

    if !params[:q].nil?
          @search = params[:q][:email_or_name_cont]
        else 
          @search = ""
    end

    @q = User.includes(:company).ransack(params[:q])
    @users = @q.result.order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
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
    # If params password is empty, remove it from the hash
    if !user_params[:password].present?
      filtered_params = user_params.except(:password, :password_confirmation)
    else
      filtered_params = user_params
    end
    if @user.update!(filtered_params)
      redirect_to users_path, notice: "Usuario actualizado correctamente"
    else
      render :edit, notice: "Error al actualizar el usuario"
    end
  end

  def destroy
    authorize! :destroy, @user
    @user.destroy
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
    params.require(:user)
          .permit(:role, :name, :lastname, :email, :password, :phone, :age, :gender, :height, :weight,
                  :home_address, :home_address_city, :home_address_province, :home_address_country, :home_address_zip_code,
                  :billing_address, :billing_address_city, :billing_address_province, :billing_address_country, :billing_address_zip_code,
                  :company_name, :image)
  end
end
