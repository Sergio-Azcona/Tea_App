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

        params = ({
        title: "Basic Plan",
        price: 10.99,
        frequency: 1,
        tea_id: @teas.second.id,
        })

        post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: JSON.generate(subscription: params)
        
        #DB record created 
        last_created = Subscription.last                
        expect(last_created.customer_id).to eq(@customer.id)
        expect(last_created.tea_id).to eq(params[:tea_id])
        expect(last_created.status).to eq(true)
        expect(last_created.price).to eq(params[:price])
        expect(last_created.frequency).to eq(params[:frequency])
        
        #response to client
        expect(response).to be_successful
        expect(response.status).to eq(200)

        request_response = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
        # require 'pry';binding.pry
        expect(request_response[:customer_id]).to eq(last_created.customer_id)
        expect(request_response[:tea_id]).to eq(last_created.tea_id)
        expect(request_response[:status]).to eq(last_created.status)
        expect(request_response[:price]).to eq(last_created.price)
        expect(request_response[:frequency]).to eq(last_created.frequency)
      end
    end
  end 

  describe '#Update functionality' do
    describe 'Happy path' do
      before(:each) do
        @customer = create(:customer)
        @teas = create_list(:tea, 7)
        @subscription = create(:subscription, status: false)
      end

      it '#update the subscription status' do
        expect(@subscription.status).to eq(false)
        # require 'pry';binding.pry
        headers = {"CONTENT_TYPE" => "application/json"}

        params = ({
        status: @subscription.status
        })

        patch "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id}", headers: headers, params: JSON.generate(subscription: params)

        #DB record updated 
        updated_sub = Subscription.find(@subscription.id)    
        expect(updated_sub.id).to eq(@subscription.id)
        expect(@subscription.status).to eq(false)           
        expect(updated_sub.status).to eq(true)

        #response to client
        expect(response).to be_successful
        expect(response.status).to eq(200)

        request_response = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(request_response[:id].to_i).to eq(updated_sub.id)
        expect(request_response[:attributes][:status]).to eq(updated_sub.status)
        expect(request_response[:attributes][:customer_id]).to eq(updated_sub.customer_id)
        expect(request_response[:attributes][:tea_id]).to eq(updated_sub.tea_id)
      end
    
    end
  end

end