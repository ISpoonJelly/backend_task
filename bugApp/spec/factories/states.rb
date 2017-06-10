FactoryGirl.define do
  factory :state do
    device { Faker::Lorem.word }
    os { Faker::Name.first_name }
    memory { Faker::Number.between(512, 4096) }
    storage { Faker::Number.between(8192, 4096) }
  end
end
