class MainController < ApplicationController
  before_filter :authorize

  def index
    @expenses = current_user.expenses
  end
end