class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      cookies[:auth_token] = @user.auth_token
      redirect_to '/expenses', notice: 'Thank you for signing up!'
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
