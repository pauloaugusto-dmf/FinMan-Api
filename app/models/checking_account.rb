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
#  index_checking_accounts_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class CheckingAccount < ApplicationRecord
  belongs_to :account
  has_one :user, through: :account

  with_options presence: true do
    validates :agency, format: { with: /\A\d+\z/ }
    validates :account_number, format: { with: /\A\d+\z/ }, uniqueness: { scope: :agency }
    validates :monthly_fee, numericality: { greater_than_or_equal_to: 0 }
  end
end
