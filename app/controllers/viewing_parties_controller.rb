class ViewingPartiesController < ApplicationController
  # before_action :find_user
  before_action :current_user

  def new
    @movie = MovieFacade.create_single_movie(params[:movie_id])
    if current_user.nil?
      flash[:error] = "Please register and/or log in to create Parties"
      redirect_to "/movies/#{@movie.id}"
    end
  end

  def create
    # @party = Party.create(viewing_party_params)
    # # creates an empty string so we need to shift
    # params[:invite_users].shift
    # invitees_id = params[:invite_users]
    # invitees_id.each do |invitee_id|
    #   PartyUser.create!(user_id: invitee_id, party_id: @party.id)
    # end
    # PartyUser.create!(user_id: params[:id], party_id: @party.id)
    # redirect_to "/dashboard"
    @party = Party.create(viewing_party_params)
    params[:invite_users].each do |invitee_id|
      PartyUser.create(user_id: invitee_id, party_id: @party.id) if invitee_id != ""
    end
    redirect_to "/dashboard"
  end

  private

  def viewing_party_params
    {
      start_time: params[:start_time],
      host: params[:id],
      duration: params[:duration],
      movie_id: params[:movie_id],
      host_name: current_user.name
    }
  end
end
