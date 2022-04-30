require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { expect(have_many(:accounts)) }
  end

  describe 'validations' do
    it { expect(validate_presence_of(:name)) }
    it { expect(validate_presence_of(:email)) }
    it { expect(validate_presence_of(:password)) }
  end
end
