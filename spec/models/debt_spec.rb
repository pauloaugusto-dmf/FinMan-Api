require 'rails_helper'

RSpec.describe Debt, type: :model do
  describe 'associations' do
    it { expect(belong_to(:accounts)) }
  end

  describe 'validations' do
    it { expect(validate_presence_of(:name)) }
    it { expect(validate_presence_of(:value)) }
    it { expect(validate_presence_of(:is_installments)) }
  end
end
