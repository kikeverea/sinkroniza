class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[ show edit update destroy ]

  def index
    @title = "Subscripciones"
    @subscriptions = Subscription.all
  end

  def show
    @title = "Subscripción"
  end

  def new
    @title = "Nueva Suscripción"
    @subscription = Subscription.new
  end

  def edit
    @title = "Editar Subscripción"
  end

  def create
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to subscriptions_path, notice: "Subscripción creada" }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @subscription.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to subscriptions_path, notice: "Subscripción actualizada" }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @subscription.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @subscription.destroy!

    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: "Subscripción eliminada" }
      format.json { head :no_content }
    end
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params.require(:subscription).permit(:name, :description, :max_users, :status)
  end
end
