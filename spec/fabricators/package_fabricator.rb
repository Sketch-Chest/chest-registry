Fabricator(:package) do
  name { Faker::Internet.user_name(nil, ['_']) }
  user
end
