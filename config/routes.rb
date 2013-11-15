TwitterClone::Application.routes.draw do
    resources :users
    resources :tweets
    resources :relationships
    resources :stars
    root to: 'tweets#index'

    get "login" => 'sessions#new', as: 'login'
    post "login" => 'sessions#create'
    get "signup" => 'users#new', as: 'signup'
    get 'logout' => 'sessions#destroy', as: 'logout'
    get '/users/follow/id' => 'users#follow'
end
