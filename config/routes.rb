Rails.application.routes.draw do

  root to: 'pages#home'


  devise_for :users
  as :user do
    get "/login" => "devise/sessions#new"
  end

  resources :teams do
    resources :memberships, controller: 'teams/memberships'
  end
  resources :users

end
