class Users::SessionsController < Devise::SessionsController
  prepend_before_action :require_no_authentication, only: [:new, :create]
  skip_before_action :verify_authenticity_token, :only => [:create, :new]

  respond_to :json, :html
  layout "devise"


  # POST /resource/sign_in
  def create
    user = User.find_by(email: params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      set_flash_message!(:notice, :signed_in)
      sign_in(user)

      user.update!(last_connection: Time.current)

      respond_to do |format|
        format.html  { redirect_to root_path }
        format.json  { render json: user.as_json }
      end
    else

      respond_to do |format|
        format.html  { redirect_to root_path, notice: "Error usuario o password" }
        format.json  {
          render json: { error: "No such user; check the submitted email address" }, status: 400
        }
      end
    end
  end

  private

  def respond_to_on_destroy
    head :no_content
  end
end