require 'faker'
FactoryBot.define do 
  factory :tea do
    title { Faker::Tea.variety  }
    description {  "teas give life" } #for some reason, this and other faker does not work: Faker::HitchhikersGuideToTheGalaxy.marvin_quote
    temperature { Faker::Number.within(range: 140..212) }
    brew_time { Faker::Number.between(from: 1, to: 30) }
  end
end
