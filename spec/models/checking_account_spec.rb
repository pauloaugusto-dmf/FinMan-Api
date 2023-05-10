# == Schema Information
#
# Table name: checking_accounts
#
#  id             :bigint           not null, primary key
#  account_number :string
#  agency         :string
#  monthly_fee    :decimal(, )      default(0.0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  account_id     :bigint           not null
#
# Indexes
#
#  index_checking_accounts_on_account_id                 (account_id)
#  index_checking_accounts_on_account_number_and_agency  (account_number,agency) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require 'rails_helper'

RSpec.describe CheckingAccount, type: :model do
  subject(:checking_account) { build :checking_account }
  subject(:other_checking_account) { build :checking_account }

  describe 'associations' do
    it { expect(belong_to(:account)) }
  end

  describe 'validations' do
    it { expect(validate_presence_of(:account_number)) }
    it { expect(validate_presence_of(:agency)) }
    it { expect(validate_presence_of(:monthly_fee)) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(checking_account).to be_valid
    end

    it 'it not valid with invalid account_number' do
      checking_account.account_number = 'teste'
      expect(checking_account).to_not be_valid
    end

    it 'it not valid with invalid agency' do
      checking_account.agency = 'teste'
      expect(checking_account).to_not be_valid
    end

    it 'it not valid with negative monthly_fee' do
      checking_account.monthly_fee = -10.00
      expect(checking_account).to_not be_valid
    end

    it 'it not valid with same number of accounts for the same agency' do
      checking_account.save
      other_checking_account.agency = checking_account.agency
      other_checking_account.account_number = checking_account.account_number

      expect(other_checking_account).to_not be_valid
    end
  end
end
