FactoryBot.define do
  factory :transaction do
    value { 0 }
    association :account_id, strategy: :build
  end
end
