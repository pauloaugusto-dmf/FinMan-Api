# == Schema Information
#
# Table name: debts
#
#  id              :bigint           not null, primary key
#  date            :datetime
#  description     :string
#  installments    :integer
#  is_installments :boolean          not null
#  name            :string           not null
#  value           :decimal(, )      default(0.0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  accounts_id     :bigint
#  tags_id         :bigint
#
# Indexes
#
#  index_debts_on_accounts_id  (accounts_id)
#  index_debts_on_tags_id      (tags_id)
#
# Foreign Keys
#
#  fk_rails_...  (accounts_id => accounts.id)
#  fk_rails_...  (tags_id => tags.id)
#
class Debt < ApplicationRecord
  belongs_to :tags, class_name: 'Tag', optional: true
  belongs_to :accounts, class_name: 'Account'
  has_many :transactions, as: :typeable, dependent: :destroy

  with_options presence: true do
    validates :name
    validates :value, numericality: true
    validates :is_installments
  end
end
