class AdminController < ApplicationController
  before_action :authenticate_user!

  def index
    @title = "Dashboard"
    @logs = Log.all.order(id: :desc)
  end
end
