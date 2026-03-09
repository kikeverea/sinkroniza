class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :set_current_user
    before_action :set_show_company

    rescue_from CanCan::AccessDenied do |_exception|
      redirect_to root_path, :notice => "No tienes permiso para realizar esta acción."
    end

    private

    def set_current_user
      Current.user = current_user
      Current.ability = current_ability
      Current.company = current_user&.company
    end

    def set_show_company
      @show_company = current_user.company.nil?
    end
end
