require 'logging'

module CheckingAccounts
  class CreateCheckingAccounts < ApplicationService
    def initialize(params, current_user)
      @params = params
      @current_user = current_user
      @errors = []
      @logger = Logging.logger['CreateCheckingAccount']
    end

    def call
      @account = Accounts::CreateAccounts.call(@params['account_attributes'], @current_user)
      @checking_account = CheckingAccount.new(checking_account_params)

      if @checking_account.save
        @logger.info "Checking account #{@checking_account.id} created"
        Result.new(true, @checking_account)
      else
        add_errors
        @logger.error "Failed to create checking account: #{@errors.as_json}"
        Result.new(false, nil, @errors)
      end
    end

    def checking_account_params
      {
        account_id: @account&.data&.id,
        account_number: @params[:account_number],
        agency: @params[:agency],
        monthly_fee: @params[:monthly_fee]
      }
    end

    def add_errors
      @errors << @account.error if @account.error.present?
      @errors << @checking_account.errors if @checking_account.errors.present?
    end
  end
end
