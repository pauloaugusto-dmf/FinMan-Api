# == Schema Information
#
# Table name: debts
#
#  id              :bigint           not null, primary key
#  date            :datetime
#  description     :string
#  installments    :integer
#  is_installments :boolean          not null
#  name            :string           not null
#  value           :decimal(, )      default(0.0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  accounts_id     :bigint
#  tags_id         :bigint
#
# Indexes
#
#  index_debts_on_accounts_id  (accounts_id)
#  index_debts_on_tags_id      (tags_id)
#
# Foreign Keys
#
#  fk_rails_...  (accounts_id => accounts.id)
#  fk_rails_...  (tags_id => tags.id)
#
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
