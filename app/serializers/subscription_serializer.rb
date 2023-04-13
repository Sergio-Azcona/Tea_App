class SubscriptionSerializer
  # include JSONAPI::Serializer
  #         set_type :subscription
  #         attributes  :id, 
  #                     :title, 
  #                     :price, 
  #                     :frequency, 
  #                     :tea_id, 
  #                     :customer_id
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
                            tea_id: subscription.tea_id,
                            customer_id: subscription.customer_id
              }
        }
    }
  end

end