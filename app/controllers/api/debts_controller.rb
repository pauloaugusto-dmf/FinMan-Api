module Api
  class DebtsController < ApplicationController
    before_action :set_debt, only: %i[show update destroy]
    before_action :set_debts, only: %i[index]

    # GET /debts
    def index
      render json: @debts
    end

    # GET /debts/1
    def show
      render json: @debt
    end

    # POST /debts
    def create
      @debt = Debt.new(debt_params)

      if @debt.save
        render json: @debt, status: :created, location: api_debts_url(@debt)
      else
        render json: @debt.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /debts/1
    def update
      if @debt.update(debt_params)
        render json: @debt
      else
        render json: @debt.errors, status: :unprocessable_entity
      end
    end

    # DELETE /debts/1
    def destroy
      @debt.destroy
    end

    private

    def set_debt
      @debt = Debt.find(params[:id])
    end

    def set_debts
      @debts = Debt.all
    end

    def debt_params
      params.require(:debt).permit(:name, :description, :value, :date, :is_installments,
                                   :installments, :accounts_id, :tags_id)
    end
  end
end
