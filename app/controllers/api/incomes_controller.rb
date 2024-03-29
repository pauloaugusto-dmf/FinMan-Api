module Api
  class IncomesController < ApplicationController
    before_action :set_income, only: %i[show update destroy]
    before_action :set_incomes, only: %i[index]

    # GET /incomes
    def index
      @incomes = Income.all

      render json: @incomes
    end

    # GET /incomes/1
    def show
      render json: @income
    end

    # POST /incomes
    def create
      @income = Income.new(income_params)

      if @income.save
        render json: @income, status: :created, location: api_debts_url(@income)
      else
        render json: @income.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /incomes/1
    def update
      if @income.update(income_params)
        render json: @income
      else
        render json: @income.errors, status: :unprocessable_entity
      end
    end

    # DELETE /incomes/1
    def destroy
      @income.destroy
    end

    private

    def set_income
      @income = Income.find(params[:id])
    end

    def set_incomes
      @incomes = Income.all
    end

    def income_params
      params.require(:income).permit(:name, :description, :value, :date, :continuous, :accounts_id,
                                     :tags_id)
    end
  end
end
