# == Schema Information
#
# Table name: incomes
#
#  id          :bigint           not null, primary key
#  continuous  :boolean          not null
#  date        :datetime
#  description :string
#  name        :string           not null
#  value       :decimal(, )      default(0.0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  accounts_id :bigint
#  tags_id     :bigint
#
# Indexes
#
#  index_incomes_on_accounts_id  (accounts_id)
#  index_incomes_on_tags_id      (tags_id)
#
# Foreign Keys
#
#  fk_rails_...  (accounts_id => accounts.id)
#  fk_rails_...  (tags_id => tags.id)
#
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
