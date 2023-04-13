# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  balance    :decimal(, )      default(0.0), not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Account < ApplicationRecord
  has_many :transactions
  belongs_to :user

  with_options presence: true do
    validates :name
    validates :balance, numericality: true
  end
end
