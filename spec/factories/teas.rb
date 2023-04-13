FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety  }
    description {  Faker::MichaelScott.quote }
    temperature { Faker::Number.within(range: 140..212) }
    brew_time { Faker::Number.between(from: 1, to: 30) }
  end
end
