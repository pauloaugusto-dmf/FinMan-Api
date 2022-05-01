module Transactions
  class CreateTransactions < ApplicationService
    def initialize(account, params)
      @account = account
      @params = params
      @errors = []
    end

    def call
      @transaction = create_transaction

      if @transaction.save
        Result.new(true, @transaction) if add_account_balance
      else
        @errors << @transaction.errors.full_messages
        Result.new(false, nil, @errors.join(','))
      end
    end

    private

    def create_transaction
      Transaction.new(transaction_params)
    end

    def add_account_balance
      AccountOperations::AddAccountBalance.call(@transaction, @account)
    end

    def transaction_params
      {
        account: @account,
        value: @params[:value]
      }
    end
  end
end
