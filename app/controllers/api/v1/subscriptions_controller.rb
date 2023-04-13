class API::V1::SuscriptionsController < ApplicationController

  def index
  end

  def create
    require 'pry';binding.pry
  end

  def update
  end

  private

  def subscription_params
    params.require(:subscription).permit(:customer_id, :tea_id)
  end

end