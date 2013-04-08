class MainController < ApplicationController
  def index
    @expenses = Expense.all
  end
end