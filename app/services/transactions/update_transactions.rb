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

      if @transaction.update(transaction_params)
        add_account_balance
        Result.new(true, @transaction)
      else
        add_account_balance
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
