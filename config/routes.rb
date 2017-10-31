Rails.application.routes.draw do

root 'posts#index'

get '/signup' => 'users#new'
post '/users' => 'users#create'

get 'login' => 'sessions#new'
post '/login' => 'sessions#create'
get '/logout' => 'sessions#destroy'

resources :posts do
  resources :comments, only: [:show, :new, :create]
end

end
