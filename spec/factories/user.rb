FactoryGirl.define do
  factory :user do
    name { Faker::Internet.user_name(nil, ['_']) }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
  end
end
