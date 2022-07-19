Rails.application.routes.draw do
  get '/', to: 'landing#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'session#create'

  get '/users/register', to: 'users#new'
  get '/users/:id/discover', to: 'discover#index'
  get '/dashboard', to: 'users#show'
  post '/users/register', to: 'users#create'

  get '/users/:id/movies', to: 'movies#index'
  get '/users/:id/movies/:movie_id/viewing-party/new', to: 'viewing_parties#new'
  get '/users/:id/movies/:movie_id', to: 'movies#show'
  post '/users/:id/movies/:movie_id', to: 'viewing_parties#create'
end
