module Accounts
  module AccountsOperations
    class SubAccountBalance < ApplicationService
      def initialize(value, account)
        @value = value
        @account = account
      end

      def call
        sub_account_balance(@value)
      end

      def sub_account_balance(value)
        new_balance = @account.balance - value
        @account.update(balance: new_balance)
      end
    end
  end
end
