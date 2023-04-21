module Api
  class CheckingAccountsController < ApplicationController
    before_action :set_checking_account, only: %i[show update destroy]
    before_action :set_checking_accounts, only: %i[index]
    before_action -> { authorize_user(CheckingAccount) }, only: %i[show update destroy]

    # GET /checking_accounts
    def index
      @checking_accounts = @checking_accounts
                           .ransack(params[:q])
                           .result(distinct: true)
                           .page(params[:page])
                           .per(params[:page_size])

      render json: CheckingAccounts::Serialize.collection_as_json(@checking_accounts)
    end

    # GET /checking_accounts/1
    def show
      render json: CheckingAccounts::Serialize.as_json(@checking_account)
    end

    # POST /checking_accounts
    def create
      result = CheckingAccounts::CreateCheckingAccounts.call(checking_account_params, current_user)

      if result.success?
        render json: result.data.as_json(include: :account), status: :created
      else
        render json: { error: result.error }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /checking_accounts/1
    def update
      result = CheckingAccounts::UpdateCheckingAccounts.call(checking_account_params, current_user, @checking_account)

      if result.success?
        render json: result.data.as_json(include: :account), status: :ok
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

    def set_checking_accounts
      @checking_accounts = CheckingAccount.joins(:account).where(accounts: { user_id: current_user.id })
    end

    # Only allow a list of trusted parameters through.
    def checking_account_params
      params.require(:checking_account).permit(:account_number, :monthly_fee, :agency,
                                               account_attributes: %i[active balance name type])
    end
  end
end
