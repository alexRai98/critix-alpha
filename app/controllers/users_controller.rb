class UsersController < ApplicationController
  layout "welcome"
  skip_before_action :authorized, only: [:new,:create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to companies_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username,:password,:brith_date,:email)
  end

end
