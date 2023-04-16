module Accounts
  class CreateAccounts < ApplicationService
    validate :valid_balance?

    def initialize(params, current_user)
      @params = params
      @current_user = current_user
    end

    def call
      @account = create_account

      if valid? && @account.save
        create_transaction(@account, transaction_params) if opening_balance?
        Result.new(true, @account)
      else
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
      return unless @params[:balance].present?

      errors.add(:balance, 'invalid parameters for balance') unless @params[:balance].is_a?(Numeric)
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
