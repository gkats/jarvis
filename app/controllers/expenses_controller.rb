class ExpensesController < ApplicationController
  respond_to :json

  def create
    respond_with Expense.create expense_params
  end

  def update
    respond_with Expense.update params[:id], expense_params
  end

  private

    def expense_params
      params.permit(:price, :date, :description, :tag_list)
    end
end