TwitterClone::Application.routes.draw do
    resources :users
    resources :tweets
    resources :relationships
    resources :stars
    root to: 'tweets#index'

    get "/username/:username" => 'users#show_name'
    get "login" => 'sessions#new', as: 'login'
    post "login" => 'sessions#create'
    get "signup" => 'users#new', as: 'signup'
    get 'logout' => 'sessions#destroy', as: 'logout'
    get '/users/follow/:id' => 'users#follow'
    get '/users/unfollow/:id' => 'users#unfollow'
    get '/tweets/favorite/:id' => 'tweets#favorite'
    get '/tweets/retweet/:id' => 'tweets#retweet'
    get '/hashtags/:id' => 'hashtags#show'
end
