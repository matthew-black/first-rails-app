Rails.application.routes.draw do

root 'posts#index'
resources :posts, only: [:index, :new, :show, :create, :destroy]
# get '/posts' => 'posts#index'
# get '/posts/new' => 'posts#new'
# get '/posts/:id' => 'posts#show'
# post '/posts' => 'posts#create'

end
