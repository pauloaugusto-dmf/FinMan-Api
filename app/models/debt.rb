class Debt < ApplicationRecord
  belongs_to :tags, class_name: 'Tag', optional: true
  belongs_to :accounts, class_name: 'Account'
  has_many :transactions, as: :typeable

  with_options presence: true do
    validates :name
    validates :value, numericality: true
    validates :is_installments
  end
end
