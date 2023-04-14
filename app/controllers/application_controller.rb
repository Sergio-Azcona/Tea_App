class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :no_record_response

  # require 'pry';binding.pry
  def no_record_response
    # require 'pry';binding.pry
    error = rescue_handlers.join(' ')
    render json: ErrorSerializer.bad_data(error, 404), status: :not_found
  end
  # rescue_handlers
  # => [["ActiveRecord::RecordNotFound", :no_record_response]]

end
