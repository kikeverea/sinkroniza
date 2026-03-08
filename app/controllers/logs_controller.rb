class LogsController < ApplicationController
  before_action :set_log, only: %i[ show destroy ]

  def index
    @title = "Registro de acciones"
    @logs = Log.all.order(id: :desc)
  end

  def show
  end

  def destroy
    @log.destroy!

    respond_to do |format|
      format.html { redirect_to logs_url, notice: "Log was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private

  def set_log
    @log = Log.find(params[:id])
  end

  def log_params
    params.require(:log).permit(:user_id, :user_name, :action)
  end
end
