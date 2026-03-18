class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[ show edit update destroy ]

  def index
    authorize! :read, Subscription
    @title = "Planes"

    @search = params[:q].nil? ? "" : params[:q][:name_cont]
    @query = Subscription.ransack(params[:q])

    @subscriptions = @query.result.accessible_by(current_ability).order(:name).paginate(page: params[:page] || 1, per_page: params[:per_page] || 15)
  end

  def ransack
    @query = Subscription.ransack(params[:q])
    @subscriptions = @query.result.accessible_by(current_ability).order(:name).paginate(page: params[:page] || 1, per_page: params[:per_page] || 15)

    render turbo_stream: turbo_stream.replace("subscriptions-index", partial: "subscriptions/index")
  end

  def show
    @title = "Plan"
  end

  def new
    @title = "Nuevo Plan"
    @subscription = Subscription.new
  end

  def edit
    @title = "Editar Plan"
  end

  def create
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to subscriptions_path, notice: "Plan creado" }
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
        format.html { redirect_to subscriptions_path, notice: "Plan actualizado" }
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
      format.html { redirect_to subscriptions_url, notice: "Plan eliminado" }
      format.json { head :no_content }
    end
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params.require(:subscription).permit(:name, :max_users, :price, :description, :status)
  end
end
