module Api
  class TransactionsController < ApplicationController
    before_action :set_account, only: %i[show index create update destroy]

    # GET /transactions
    def index
      render json: @account.transactions.as_json(only: %i[id value])
    end

    # GET /transactions/1
    def show
      @transaction = @account.transactions.find(params[:id])

      render json: @transaction
    end

    # POST /transactions
    def create
      result = Transactions::CreateTransactions.call(@account, transaction_params)

      if result.success?
        render json: result.data, status: :created
      else
        render json: { error: result.error }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /transactions/1
    def update
      result = Transactions::UpdateTransactions.call(params[:id], @account, transaction_params)

      if result.success?
        render json: result.data
      else
        render json: { error: result.error }, status: :unprocessable_entity
      end
    end

    # DELETE /transactions/1
    def destroy
      result = Transactions::DestroyTransactions.call(params[:id], @account)

      if result.success?
        render status: :no_content
      else
        render json: { error: result.error }, status: :unprocessable_entity
      end
    end

    private

    def transaction_params
      params.require(:transaction).permit(:value)
    end

    def set_account
      @account = Account.find(params[:account_id])
    end
  end
end
