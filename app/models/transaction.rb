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
class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :typeable, polymorphic: true, optional: true

  with_options presence: true do
    validates :value, numericality: true
  end
end
