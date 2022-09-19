class Income < ApplicationRecord
  belongs_to :tags, class_name: 'Tag', optional: true
  belongs_to :accounts, class_name: 'Account'

  with_options presence: true do
    validates :name
    validates :value, numericality: true
    validates :continuous
  end
end
