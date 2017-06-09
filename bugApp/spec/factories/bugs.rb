FactoryGirl.define do
  factory :bug do
    appToken { Faker::Lorem.sentence }
    number { Faker::Number.number(8) }
    status { Faker::Number.between(0, 2) }
    priority { Faker::Number.between(0, 2) }
    comment { Faker::Friends.quote }
    association :state, factory: :state
  end
end
