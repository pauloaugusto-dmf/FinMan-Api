# == Schema Information
#
# Table name: transactions
#
#  id            :bigint           not null, primary key
#  typeable_type :string
#  value         :decimal(, )      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  account_id    :bigint
#  typeable_id   :bigint
#
# Indexes
#
#  index_transactions_on_account_id  (account_id)
#  index_transactions_on_typeable    (typeable_type,typeable_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
FactoryBot.define do
  factory :transaction do
    value { 0 }
    association :account_id, strategy: :build
  end
end
