class ExpensesController < ApplicationController
  respond_to :json

  before_filter :authorize

  def create
    respond_with Expense.create expense_params.merge(user_id: current_user.id)
  end

  def update
    respond_with Expense.update params[:id], expense_params
  end

  private

    def expense_params
      params.permit(:price, :date, :description, :tag_list)
    end
end