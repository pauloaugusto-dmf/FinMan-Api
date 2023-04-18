require 'logging'

module Transactions
  class CreateTransactions < ApplicationService
    def initialize(account, params)
      @account = account
      @params = params
      @errors = []
      @logger = Logging.logger['CreateTransactions']
    end

    def call
      @transaction = create_transaction

      if @transaction.save
        @logger.info "Transaction #{@transaction.id} created"
        Result.new(true, @transaction) if add_account_balance
      else
        @errors << @transaction.errors.full_messages
        @logger.error "Failed to create transaction: #{@errors.as_json}"
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
