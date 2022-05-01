class Transaction < ApplicationRecord
  belongs_to :account

  with_options presence: true do
    validates :value, numericality: true
  end
end
