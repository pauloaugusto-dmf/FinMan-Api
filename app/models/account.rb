class Account < ApplicationRecord
  has_many :transactions
  belongs_to :user

  with_options presence: true do
    validates :name
    validates :balance, numericality: true
  end
end
