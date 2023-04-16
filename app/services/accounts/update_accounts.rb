module Accounts
  class UpdateAccounts < ApplicationService
    validate :balance_present?

    def initialize(params, current_user, account)
      @params = params
      @current_user = current_user
      @account = account
    end

    def call
      if valid? && @account.update(@params)
        Result.new(true, @account)
      else
        Result.new(false, nil, @account.errors)
      end
    end

    private

    def balance_present?
      errors.add(:balance, 'cannot be changed on update') if @params[:balance].present?
    end
  end
end
