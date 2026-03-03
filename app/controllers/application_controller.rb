class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    rescue_from CanCan::AccessDenied do |exception|
        #sign_out current_user
        redirect_to root_path, :notice => "No tienes permiso para realizar esta acción."
    end

    
end
