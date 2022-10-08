require 'rails_helper'

RSpec.describe Income, type: :model do
  describe 'associations' do
    it { expect(belong_to(:accounts)) }
  end

  describe 'validations' do
    it { expect(validate_presence_of(:name)) }
    it { expect(validate_presence_of(:value)) }
    it { expect(validate_presence_of(:continuous)) }
  end
end
