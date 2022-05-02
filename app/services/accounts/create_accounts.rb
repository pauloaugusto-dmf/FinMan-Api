module Accounts
  class CreateAccounts < ApplicationService
    def initialize(params, current_user)
      @params = params
      @current_user = current_user
      @errors = []
    end

    def call
      @account = create_account

      if valid_parameters? && @account.save
        create_transaction(@account, transaction_params) if opening_balance?
        Result.new(true, @account)
      else
        @errors << @account.errors.full_messages
        Result.new(false, nil, @errors.join(','))
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
      @params[:balance].present? && !@params[:balance].zero?
    end

    def valid_parameters?
      if @params[:balance].present?
        return true if integer?(@params[:balance]) || float?(@params[:balance])

        @errors << 'Invalid parameters for balance'
        return false
      end

      true
    end

    def float?(value)
      value.instance_of?(Float)
    end

    def integer?(value)
      value.instance_of?(Integer)
    end

    def account_params
      {
        name: @params[:name]
      }
    end

    def transaction_params
      {
        value: @params[:balance]
      }
    end
  end
end
