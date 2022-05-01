module Transactions
  module AccountOperations
    class AddAccountBalance < ApplicationService
      def initialize(transaction, account)
        @transaction = transaction
        @account = account
      end

      def call
        add_account_balance(@transaction)
      end

      def add_account_balance(transaction)
        new_balance = @account.balance + transaction.value
        @account.update(balance: new_balance)
      end
    end
  end
end
