require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'validations' do
    it { expect(validate_presence_of(:name)) }
  end
end
