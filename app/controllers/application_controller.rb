class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :no_record_response

  def no_record_response
    # require 'pry';binding.pry
    error = rescue_handlers.join(' ')
    render json: ErrorSerializer.bad_data(error, 400), status: :bad_request
  end
  # rescue_handlers
  # => [["ActiveRecord::RecordNotFound", :no_record_response]]

end
