FactoryBot.define do
  factory :tag do
    name { Faker::Commerce.color }
  end
end
