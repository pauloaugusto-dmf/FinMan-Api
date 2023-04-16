module CheckingAccounts
  class CreateCheckingAccounts < ApplicationService
    include ActiveModel::Validations

    def initialize(params, current_user)
      @params = params
      @current_user = current_user
      @errors = []
    end

    def call
      @account = Accounts::CreateAccounts.call(@params['account_attributes'], @current_user)
      @checking_account = CheckingAccount.new(checking_account_params)

      if @checking_account.save
        Result.new(true, @checking_account)
      else
        @errors << @account.error
        @errors << @checking_account.errors
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
  end
end
