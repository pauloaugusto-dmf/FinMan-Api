require 'logging'

module Accounts
  class UpdateAccounts < ApplicationService
    validate :balance_present?

    def initialize(params, current_user, account)
      @params = params
      @current_user = current_user
      @account = account
      @logger = Logging.logger['UpdateAccount']
    end

    def call
      if valid? && @account.update(@params)
        @logger.info "Account #{@account.id} updated"
        Result.new(true, @account)
      else
        @logger.error "Failed to update account: #{@account.errors.as_json}"
        Result.new(false, nil, @account.errors)
      end
    end

    private

    def balance_present?
      return unless @params[:balance].present?

      @logger.error 'Balance cannot be changed on update'
      errors.add(:balance, 'cannot be changed on update')
    end
  end
end
