module Transactions
  class UpdateTransactions < ApplicationService
    def initialize(id, account, params)
      @id = id
      @params = params
      @account = account
      @errors = []
    end

    def call
      @transaction = set_transaction
      sub_account_balance

      add_account_balance
      if @transaction.update(transaction_params)
        Result.new(true, @transaction)
      else
        @errors << @transaction.errors.full_messages
        Result.new(false, nil, @errors.join(','))
      end
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
