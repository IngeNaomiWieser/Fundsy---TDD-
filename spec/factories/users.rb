# One important rule about factories is that they should always valid recors (any number of different valid records)

# The idea is that anytime we request a record or attributes from the factory it should give us a valid record or valid attributes that we can further tweak to suit our needs (or to make them valid).

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| Faker::Internet.email.gsub('@', "-#{n}@") }  # how we will generate a unique emailaddress
    password 'supersecret'
  end
end
