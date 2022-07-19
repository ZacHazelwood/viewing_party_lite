Rails.application.routes.draw do
  get '/', to: 'landing#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/users/register', to: 'users#new'
  get '/discover', to: 'discover#index'
  get '/dashboard', to: 'users#show'
  post '/users/register', to: 'users#create'

  get '/movies', to: 'movies#index'
  get '/movies/:movie_id/viewing-party/new', to: 'viewing_parties#new'
  get '/movies/:movie_id', to: 'movies#show'
  post '/movies/:movie_id', to: 'viewing_parties#create'
end
