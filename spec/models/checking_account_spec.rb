# == Schema Information
#
# Table name: checking_accounts
#
#  id             :bigint           not null, primary key
#  account_number :string
#  agency         :string
#  monthly_fee    :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  account_id     :bigint           not null
#
# Indexes
#
#  index_checking_accounts_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require 'rails_helper'

RSpec.describe CheckingAccount, type: :model do
  describe 'associations' do
    it { expect(belong_to(:account)) }
  end

  describe 'validations' do
    it { expect(validate_presence_of(:account_number)) }
    it { expect(validate_presence_of(:agency)) }
    it { expect(validate_presence_of(:monthly_fee)) }
  end
end
