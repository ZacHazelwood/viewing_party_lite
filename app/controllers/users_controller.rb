class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @movies = @user.parties.map { |party| MovieFacade.create_single_movie(party.movie_id) }
    @images = @user.parties.map { |party| MovieFacade.create_single_movie_images(party.movie_id) }
  end

  def new
    @user = User.new
  end

  def create
    # @user = User.create(user_params)
    # if @user.save
    #   flash[:success] = 'Account Successfully Created'
    #   redirect_to "/users/#{@user.id}"
    # else
    #   flash[:error] = 'Invalid Entry'
    #   render 'new'
    # end
    if User.find_by(email: params[:email]) == nil
      if user_params.values.include?("") || user_params[:password] != user_params[:password_confirmation]
        flash[:error] = "Missing Credentials"
        render 'new'
      else
        user_params[:email] = user_params[:email].downcase
        new_user = User.create(user_params)
        flash[:success] = 'Account Successfully Created'
        redirect_to "/users/#{new_user.id}"
      end
    else
      flash[:error] = "Invalid Entry"
      render 'new'
    end
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: user_params[:email])
    if user.nil? || !user.authenticate(params[:password])
      flash[:error] = "Invalid Entry"
      render :login_form
    else
      flash[:success] = "Welcome #{user.name}"
      redirect_to "/users/#{user.id}"
    end
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
    # params.require(:user).permit(:name, :email)
  end
end
