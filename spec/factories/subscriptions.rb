FactoryBot.define do
  factory :subscription do
    title { Faker::Emotion.noun }
    price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    monthly_frequency { Faker::Number.decimal_part(digits: 2) }
    status { Faker::Boolean.boolean(true_ratio: 0.75) }
    customer
    subscription
  end
end