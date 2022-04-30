require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'associations' do
    it { expect(belong_to(:user)) }
  end

  describe 'validations' do
    it { expect(validate_presence_of(:name)) }
    it { expect(validate_presence_of(:balance)) }
  end
end