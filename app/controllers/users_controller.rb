class UsersController < ApplicationController
  def new
    redirect_to login_path
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user.default_project, notice: 'User was successfully created.'
    else
      puts @user.errors.full_messages
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
