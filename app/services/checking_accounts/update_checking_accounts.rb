module CheckingAccounts
  class UpdateCheckingAccounts < ApplicationService
    def initialize(params, current_user, checking_account)
      @params = params
      @current_user = current_user
      @errors = []
      @checking_account = checking_account
    end

    def call
      @account = Accounts::UpdateAccounts.call(@params['account_attributes'], @current_user, @checking_account.account)

      if @account.success? && @checking_account.update(checking_account_params)
        Result.new(true, @checking_account)
      else
        @errors << @account.error
        @errors << @checking_account.errors
        Result.new(false, nil, @errors)
      end
    end

    def checking_account_params
      @params.delete('account_attributes')
      @params
    end
  end
end
