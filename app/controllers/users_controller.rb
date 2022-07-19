class UsersController < ApplicationController
# before_action :current_user
before_action :find_user, only: [:show]
rescue_from NoMethodError, with: :no_user

  def show
    # @user = User.find_by(session[:user_id])
    @movies = @user.parties.map { |party| MovieFacade.create_single_movie(party.movie_id) }
    @images = @user.parties.map { |party| MovieFacade.create_single_movie_images(party.movie_id) }
    # if current_user.nil?
    #   flash[:error] = "Please register and/or log in to view Dashboard"
    #   redirect_to "/"
    # end
  end

  def new
    @user = User.new
  end

  def create
    if User.find_by(email: params[:email]) == nil
      if user_params.values.include?("") || user_params[:password] != user_params[:password_confirmation]
        flash[:error] = "Missing Credentials"
        render 'new'
      else
        user_params[:email] = user_params[:email].downcase
        new_user = User.create(user_params)
        session[:user_id] = new_user.id
        flash[:success] = 'Account Successfully Created'
        redirect_to "/dashboard"
      end
    else
      flash[:error] = "Invalid Entry"
      render 'new'
    end
  end


  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
    if current_user.nil?
      flash[:error] = "Please register and/or log in to view Dashboard"
      redirect_to "/"
    else
      @user = User.find(session[:user_id])
    end
  end

  def no_user
    flash[:notice] = "Invalid Entry"
    redirect_to '/login'
  end
end
