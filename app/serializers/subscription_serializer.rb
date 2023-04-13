class SubscriptionSerializer
  # include JSONAPI::Serializer
  #         set_type :subscription
  #         attributes  :id, 
  #                     :title, 
  #                     :price, 
  #                     :frequency, 
  #                     :tea_id, 
  #                     :customer_id
  def self.all_record(subscriptions)
    # require 'pry';binding.pry
    {
    "data": subscriptions.map do |subscription|
          {
            "id": subscription.id.to_s,
            "type": subscription.class.to_s.downcase,
            "attributes": {
                          title: subscription.title,
                          price: subscription.price,
                          frequency: subscription.frequency, 
                          status: subscription.status,
                          tea_id: subscription.tea_id,
                          customer_id: subscription.customer_id
            }
          }
        end
    }
  end
  
  def self.new_record(subscription)
    {
      "data": 
            {
              "id": subscription.id.to_s,
              "type": subscription.class.to_s.downcase,
              "attributes": {
                            title: subscription.title,
                            price: subscription.price,
                            frequency: subscription.frequency, 
                            status: subscription.status,
                            tea_id: subscription.tea_id,
                            customer_id: subscription.customer_id
              }
        }
    }
  end

  def self.update_status(subscription)
    {
      "data": 
            {
              "id": subscription.id.to_s,
              "type": subscription.class.to_s.downcase,
              "attributes": {
                            title: subscription.title,
                            status: subscription.status,
                            customer_id: subscription.customer_id,
                            tea_id: subscription.tea_id,
              }
        }
    }
  end

end