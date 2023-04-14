class Api::V1::SubscriptionsController < ApplicationController

  def index
    begin 
      customer = Customer.find(params[:customer_id])
      subscriptions = customer.subscriptions
      render json: SubscriptionSerializer.all_record(subscriptions)
    rescue => error
      # require 'pry';binding.pry
      render json: ErrorSerializer.bad_data(error, 400), status: :bad_request
    end 
  end

  def create
    begin 
      customer = Customer.find(params[:customer_id])
      new_sub = customer.subscriptions.create!(subscription_params)
      render json: SubscriptionSerializer.new_record(new_sub)
      # require 'pry';binding.pry
    rescue => error
      # render json: ErrorSerializer(error, 422), status: :unprocessable_entity
    end
  end

  def update
    begin
      subscription = Subscription.find(params[:id])
      subscription.toggle!(:status)
      render json: SubscriptionSerializer.update_status(subscription)
    rescue => errors
       # render json: ErrorSerializer(error, 422), status: :unprocessable_entity
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :frequency, :tea_id)
  end

end