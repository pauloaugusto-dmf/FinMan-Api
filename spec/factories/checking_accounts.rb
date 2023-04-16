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
FactoryBot.define do
  factory :checking_account do
    account_number { 'MyString' }
    monthly_fee { '9.99' }
    agency { 'MyString' }
    account
  end
end