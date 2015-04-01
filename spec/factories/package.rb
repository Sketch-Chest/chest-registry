FactoryGirl.define do
  factory :package do
    name { Faker::Internet.user_name(nil, ['_']) }
    user
  end
end
