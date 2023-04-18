module Accounts
  module AccountsOperations
    class AddAccountBalance < ApplicationService
      def initialize(value, account)
        @value = value
        @account = account
      end

      def call
        add_account_balance(@value)
      end

      def add_account_balance(value)
        new_balance = @account.balance + value
        @account.update(balance: new_balance)
      end
    end
  end
end
