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
require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'associations' do
    it { expect(belong_to(:account)) }
  end

  describe 'validations' do
    it { expect(validate_presence_of(:value)) }
  end
end
