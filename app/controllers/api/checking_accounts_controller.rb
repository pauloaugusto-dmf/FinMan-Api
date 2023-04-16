module Api
  class CheckingAccountsController < ApplicationController
    before_action :set_checking_account, only: %i[show update destroy]

    # GET /checking_accounts
    def index
      @checking_accounts = CheckingAccount.all

      render json: @checking_accounts
    end

    # GET /checking_accounts/1
    def show
      render json: @checking_account
    end

    # POST /checking_accounts
    def create
      result = CheckingAccounts::CreateCheckingAccounts.call(checking_account_params, current_user)

      if result.success?
        render json: result.data, status: :created
      else
        render json: { error: result.error }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /checking_accounts/1
    def update
      result = CheckingAccounts::UpdateCheckingAccounts.call(checking_account_params, current_user, @checking_account)

      if result.success?
        render json: result.data, status: :ok
      else
        render json: { error: result.error }, status: :unprocessable_entity
      end
    end

    # DELETE /checking_accounts/1
    def destroy
      @checking_account.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_checking_account
      @checking_account = CheckingAccount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def checking_account_params
      params.require(:checking_account).permit(:account_number, :monthly_fee, :agency,
                                               account_attributes: %i[active balance name type])
    end
  end
end
