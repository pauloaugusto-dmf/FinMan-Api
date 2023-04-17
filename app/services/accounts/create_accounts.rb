require 'logging'

module Accounts
  class CreateAccounts < ApplicationService
    validate :valid_balance?

    def initialize(params, current_user)
      @params = params
      @current_user = current_user
      @logger = Logging.logger['CreateAccount']
    end

    def call
      @account = create_account

      if valid? && @account.save
        @logger.info "Account #{@account.id} created"
        create_transaction(@account, transaction_params) if opening_balance?
        Result.new(true, @account)
      else
        @logger.error "Failed to create account: #{@account.errors.as_json}"
        Result.new(false, nil, @account.errors)
      end
    end

    private

    def create_account
      @current_user.accounts.new(account_params)
    end

    def create_transaction(account, transaction_params)
      Transactions::CreateTransactions.call(account, transaction_params)
    end

    def opening_balance?
      @params[:balance].present? && !@params[:balance].to_f.zero?
    end

    def valid_balance?
      return unless @params[:balance].present? && !@params[:balance].is_a?(Numeric)

      @logger.error "Invalid parameters for balance: ( #{@params[:balance]}, type:#{@params[:balance].class} )"
      errors.add(:balance, 'invalid parameters for balance')
    end

    def account_params
      {
        name: @params[:name],
        active: @params[:active]
      }
    end

    def transaction_params
      {
        value: @params[:balance]
      }
    end
  end
end
