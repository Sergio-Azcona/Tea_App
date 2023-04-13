require 'rails_helper'

describe 'CustomerSubscriptionAPI' do

  xdescribe 'Customer Subscription Index' do
    describe 'Happy Path' do
      before(:each) do
        @customers = create(:customer, 2)
        @subscriptions = create_list(:subscription, 7)
      end
    end
  end


  describe '#Create functionality' do
    describe 'Happy Path' do
      before(:each) do
        @customer = create(:customer)
        @teas = create_list(:tea, 7)
        
      end

      it '#creates customer relationship with subcription' do
        headers = {"CONTENT_TYPE" => "application/json"}

        # require 'pry';binding.pry
        params = ({
        title: "Basic Plan",
        price: 10.99,
        frequency: 1,
        tea_id: @teas.second.id,
        })

        post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers,  params: JSON.generate(subscription: params)
        require 'pry';binding.pry

        created_cs = Subscription.last

        expect(response).to be_successful
        expect(response.status).to eq(204)

        expect(created_cs.tea_id).to eq(item_params[:tea_id])
      end
    end
  end 


end