require 'logging'

module Transactions
  class UpdateTransactions < ApplicationService
    def initialize(id, account, params)
      @id = id
      @params = params
      @account = account
      @transaction = set_transaction
      @errors = []
      @logger = Logging.logger['UpdateTransaction']
    end

    def call
      sub_account_balance

      add_account_balance
      if @transaction.update(transaction_params)
        @logger.info "Transaction #{@transaction.id} updated"
        Result.new(true, @transaction)
      else
        @errors << @transaction.errors.full_messages
        @logger.error "Failed to update transaction: #{@errors.as_json}"
        Result.new(false, nil, @errors.join(','))
      end
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
