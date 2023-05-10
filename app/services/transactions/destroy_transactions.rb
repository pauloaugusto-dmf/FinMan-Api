require 'logging'

module Transactions
  class DestroyTransactions < ApplicationService
    def initialize(id, account)
      @id = id
      @account = account
      @transaction = set_transaction
      @errors = []
      @logger = Logging.logger['DestroyTransaction']
    end

    def call
      sub_account_balance
      transaction_id = @transaction.id

      if @transaction.destroy
        @logger.info "Transaction #{transaction_id} destroyed"
        return Result.new(true)
      end

      add_account_balance
      @errors << @transaction.errors.full_messages
      @logger.error "Failed to destroy transactiom: #{@errors.as_json}"
      Result.new(false, nil, @errors.join(','))
    end

    private

    def set_transaction
      Transaction.find(@id)
    end

    def add_account_balance
      Accounts::AccountsOperations::AddAccountBalance.call(@transaction.value, @account)
    end

    def sub_account_balance
      Accounts::AccountsOperations::SubAccountBalance.call(@transaction.value, @account)
    end

    def transaction_params
      {
        value: @params[:value]
      }
    end
  end
end
