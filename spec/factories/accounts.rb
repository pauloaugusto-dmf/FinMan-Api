FactoryBot.define do
  factory :account do
    name { Faker::Name.initials }
    balance { 0 }
    association :user_id, strategy: :build
  end
end
