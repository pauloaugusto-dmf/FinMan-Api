module Transactions
  module AccountOperations
    class SubAccountBalance < ApplicationService
      def initialize(transaction, account)
        @transaction = transaction
        @account = account
      end

      def call
        sub_account_balance(@transaction)
      end

      def sub_account_balance(transaction)
        new_balance = @account.balance - transaction.value
        @account.update(balance: new_balance)
      end
    end
  end
end
