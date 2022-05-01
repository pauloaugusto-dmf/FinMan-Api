FactoryBot.define do
  factory :transaction do
    value { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    association :account_id, strategy: :build
  end
end
