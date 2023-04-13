class Api::V1::SubscriptionsController < ApplicationController

  def index
  end

  def new
  end

  def create
    begin 
      customer = Customer.find(params[:customer_id])
      new_sub = customer.subscriptions.create!(subscription_params)
      new_sub.toggle!(:status)
      render json: SubscriptionSerializer.new_record(new_sub)
      # require 'pry';binding.pry
    rescue => error
      # render json: ErrorSerializer(error, 422), status: 422
    end
  end

  def update
    begin
      subscription = Subscription.find(params[:id])
      subscription.toggle!(:status)
      # require 'pry';binding.pry
      render json: SubscriptionSerializer.update_status(subscription)
    rescue => errors
       # render json: ErrorSerializer(error, 422), status: 422
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :frequency, :tea_id)
  end

end