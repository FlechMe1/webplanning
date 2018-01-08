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

    get '/teams/:team_id/membership/:id/promute', to: 'teams/memberships#promute', as: :promute_membership
    get '/teams/:team_id/membership/:id/destitute', to: 'teams/memberships#destitute', as: :destitute_membership
  end
  resources :users do
    resources :events, controller: 'users/events'
  end

end
