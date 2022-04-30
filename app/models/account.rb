class Account < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :name
    validates :balance
  end
end
