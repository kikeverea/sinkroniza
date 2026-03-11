class AdminController < ApplicationController
  before_action :authenticate_user!

  def index
    @title = "Dashboard"
    @logs = Log.all.order(id: :desc)

    redirect_to users_path if current_user.super_admin? || current_user.company_admin?
    redirect_to web_companies_path if current_user.user?

  end
end
