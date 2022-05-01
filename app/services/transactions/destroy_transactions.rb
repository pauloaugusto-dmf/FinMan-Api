module Transactions
  class DestroyTransactions < ApplicationService
    def initialize(id, account)
      @id = id
      @account = account
      @errors = []
    end

    def call
      @transaction = set_transaction
      sub_account_balance

      return Result.new(true) if @transaction.destroy

      add_account_balance
      @errors << @transaction.errors.full_messages
      Result.new(false, nil, @errors.join(','))
    end

    private

    def set_transaction
      Transaction.find(@id)
    end

    def add_account_balance
      AccountOperations::AddAccountBalance.call(@transaction, @account)
    end

    def sub_account_balance
      AccountOperations::SubAccountBalance.call(@transaction, @account)
    end

    def transaction_params
      {
        value: @params[:value]
      }
    end
  end
end
