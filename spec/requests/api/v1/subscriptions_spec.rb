require 'rails_helper'

describe 'CustomerSubscriptionAPI' do
  describe 'Customer Subscription Index' do
    describe 'Happy Path' do
      before(:each) do
        @customers = create_list(:customer, 2)
        @C1_subscriptions = create_list(:subscription, 5, customer: @customers.first)
        @C2_subscriptions = create_list(:subscription, 3, customer: @customers.last)
      end

      it 'returns the customers subscription records' do
        get "/api/v1/customers/#{@customers.last.id}/subscriptions"
        request_response = JSON.parse(response.body, symbolize_names: true)[:data]
        # require 'pry';binding.pry
        expect(response).to be_successful
        expect(response.status).to eq(200)
        
        # expect(request_response).to_not include(@C1_subscriptions)
        # expect(request_response).to include(@customers.last.subscriptions)
        expect(request_response.count).to eq(@C2_subscriptions.count)
        
        #entries belong to the same customer
        expect(request_response[0][:attributes][:customer_id]).to eq(@C2_subscriptions.first.customer_id)
        expect(request_response[0][:attributes][:customer_id]).to eq(@C2_subscriptions.last.customer_id)
        expect(request_response[-1][:attributes][:customer_id]).to eq(@C2_subscriptions.first.customer_id)
        expect(request_response[-1][:attributes][:customer_id]).to eq(@C2_subscriptions.last.customer_id)

        #json responses reflect DB info
        # require 'pry';binding.pry
        expect(request_response[0][:id].to_i).to eq(@C2_subscriptions.first.id)
        expect(request_response[0][:attributes][:status]).to eq(@C2_subscriptions.first.status)
        expect(request_response[0][:attributes][:price]).to eq(@C2_subscriptions.first.price)
        expect(request_response[0][:attributes][:frequency]).to eq(@C2_subscriptions.first.frequency)
        expect(request_response[0][:attributes][:tea_id]).to eq(@C2_subscriptions.first.tea_id)
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