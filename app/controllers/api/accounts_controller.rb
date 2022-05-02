module Api
  class AccountsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_account, only: %i[show update destroy]
    before_action :set_accounts, only: %i[index]

    # GET /accounts
    def index
      render json: @accounts
    end

    # GET /accounts/1
    def show
      render json: @account.as_json(include: :user)
    end

    # POST /accounts
    def create
      result = Accounts::CreateAccounts.call(account_params, current_user)

      if result.success?
        render json: result.data, status: :created
      else
        render json: { error: result.error }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /accounts/1
    def update
      if @account.update(account_params)
        render json: @account
      else
        render json: @account.errors, status: :unprocessable_entity
      end
    end

    # DELETE /accounts/1
    def destroy
      @account.destroy
    end

    private

    def set_account
      @account = current_user.accounts.find(params[:id])
    end

    def set_accounts
      @accounts = current_user.accounts.all
    end

    def account_params
      params.require(:account).permit(:name, :balance)
    end
  end
end
