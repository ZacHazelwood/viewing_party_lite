class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: user_params[:email])
    if user.nil? || !user.authenticate(params[:password])
      flash[:error] = "Invalid Entry"
      render 'new'
    else
      session[:user_id] = user.id
      flash[:success] = "Welcome #{user.name}"
      redirect_to "/dashboard"
    end
  end

  def destroy
    session.destroy
    redirect_to "/"
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
