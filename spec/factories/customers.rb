FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.safe_email }
    street_address { Faker::Address.street_address }
    state { Faker::Address.state_abbr }
    zip_code { Faker::Address.zip_code }
  end
end
