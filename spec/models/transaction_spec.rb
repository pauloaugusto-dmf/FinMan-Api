require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'associations' do
    it { expect(belong_to(:account)) }
  end

  describe 'validations' do
    it { expect(validate_presence_of(:value)) }
  end
end
