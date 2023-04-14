#### `TEA_APP README`

### Project's_Overview
Goal: record, maintain and return records of customers' subscriptions
Features: 
  1. `GET`  - return all of a customer's subscription records 
  2. `Post` - save a new customer subscription record
  3. `Patch`- updated the status of an existing customer subscription record
 
### Set_Up
run the following commands in the terminal: 
  1. `bundle install`
  2. `rails g rspec:install`
  3. `rails db:{drop,create,migrate,seed}`

### Run_Tests
run the following commands in the terminal: 
  1. `bundle exec rspec spec`

### Endpoints
## Subscription_Index
`GET /api/v1/customers/:id/subscriptions`

  # Happy_Response:
  ```
      {
          "data": [
              {
                  "id": "39",
                  "type": "subscription",
                  "attributes": {
                      "title": "anxiety",
                      "price": 810.32,
                      "frequency": 2,
                      "status": false,
                      "tea_id": 39,
                      "customer_id": 42
                  }
              }
          ]
      }
  ```

## Subscription_Create
`POST /api/v1/customers/:id/subscriptions`

  # Body
  ```
      {
      "title": "Basic Plan",
      "price": 10.99,
      "frequency": 1,
      "tea_id": 1
      }
  ```

  # Happy_Response
  ```
      {
      "data": {
          "id": "51",
          "type": "subscription",
          "attributes": {
              "title": "Basic Plan",
              "price": 10.99,
              "frequency": 1,
              "status": true,
              "tea_id": 1,
              "customer_id": 1
          }
        }
      }
  ```

## Subscription_Update
`PATCH /api/v1/customers/:id/subscriptions/:id`

  # Body
  {
    "status": "" 
  }

  # Happy_Response
  {
    "data": {
        "id": "39",
        "type": "subscription",
        "attributes": {
            "title": "anxiety",
            "status": true,
            "customer_id": 42,
            "tea_id": 39
        }
    }
  }

### Error_Handling
At the moment we are only handling RecordNotFound scenarios

  # Sad_Response
  {
    "errors": [
        {
            "error_message": "ActiveRecord::RecordNotFound no_record_response",
            "status": "404"
        }
    ]
  }