class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :set_current_user

    rescue_from CanCan::AccessDenied do |_exception|
      redirect_to root_path, :notice => "No tienes permiso para realizar esta acción."
    end

    private

    def set_current_user
      Current.user = current_user
    end
end
