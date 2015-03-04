Fabricator(:user) do
  name { Faker::Internet.user_name(nil, ['_']) }
  email { Faker::Internet.email }
  password { Faker::Internet.password }
  password_confirmation {|attrs| attrs[:password] }
end
