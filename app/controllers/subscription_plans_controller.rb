class SubscriptionPlansController < ApplicationController
  before_action :set_subscription, only: %i[ show edit update destroy ]

  def index
    authorize! :read, SubscriptionPlan
    @title = "Suscripciones"

    @search = params[:q].nil? ? "" : params[:q][:name_cont]
    @q = SubscriptionPlan.ransack(params[:q])

    @subscription_plans = @q.result.accessible_by(current_ability).order(:name).paginate(page: params[:page] || 1, per_page: params[:per_page] || 15)
  end

  def show
    @title = "Subscripción"
  end

  def new
    @title = "Nueva Suscripción"
    @subscription_plan = SubscriptionPlan.new
  end

  def edit
    @title = "Editar Subscripción"
  end

  def create
    @subscription_plan = SubscriptionPlan.new(subscription_params)

    respond_to do |format|
      if @subscription_plan.save
        format.html { redirect_to subscriptions_path, notice: "Subscripción creada" }
        format.json { render :show, status: :created, location: @subscription_plan }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @subscription_plan.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @subscription_plan.update(subscription_params)
        format.html { redirect_to subscriptions_path, notice: "Subscripción actualizada" }
        format.json { render :show, status: :ok, location: @subscription_plan }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @subscription_plan.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @subscription_plan.destroy!

    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: "Subscripción eliminada" }
      format.json { head :no_content }
    end
  end

  private

  def set_subscription
    @subscription_plan = SubscriptionPlan.find(params[:id])
  end

  def subscription_params
    params.require(:subscription_plan).permit(:name, :description, :max_users, :status)
  end
end
