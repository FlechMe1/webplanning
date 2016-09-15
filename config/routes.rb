Rails.application.routes.draw do

  mount RailsEmailPreview::Engine, at: 'emails'
  resources :events
  root to: 'pages#home'


  devise_for :users
  as :user do
    get "/login" => "devise/sessions#new"
  end

  resources :teams do
    resources :memberships, controller: 'teams/memberships'
    resources :events, controller: 'teams/events'
  end
  resources :users do
    resources :events, controller: 'users/events'
  end

end
