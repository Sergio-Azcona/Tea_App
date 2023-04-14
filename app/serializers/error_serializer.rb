class ErrorSerializer
  
  def self.bad_data(error, status)
    { "errors": 
              [
                {
                "error_message":  error,
                "status": status.to_s
                }
              ]
    }
  end
end