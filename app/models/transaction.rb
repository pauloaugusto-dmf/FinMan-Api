class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :typeable, polymorphic: true, optional: true

  with_options presence: true do
    validates :value, numericality: true
  end
end
