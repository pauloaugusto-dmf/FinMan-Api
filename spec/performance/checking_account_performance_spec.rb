require 'rails_helper'

RSpec.describe 'CheckingAccount performance', type: :performance do
  let(:account) { create(:account) }

  it 'creates a new CheckingAccount in less than 100ms' do
    expect do
      Benchmark.realtime do
        create(:checking_account, account: account)
      end
    end.to perform_under(10).ms
  end

  it 'creates multiple checking accounts in less than 1 second' do
    expect do
      Benchmark.realtime do
        10.times do
          create(:checking_account, account: account)
        end
      end
    end.to perform_under(100).ms
  end
end
