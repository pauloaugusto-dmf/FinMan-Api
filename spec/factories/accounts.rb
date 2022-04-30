FactoryBot.define do
  factory :account do
    name { Faker::Name.initials }
    balance { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    association :user_id, strategy: :build
  end
end
