Rails.application.routes.draw do

  mount RailsEmailPreview::Engine, at: 'emails'
  devise_for :users, controllers: {
    invitations: "users/invitations"
  }


  authenticated :user do
    root to: 'pages#home', as: :home


    resources :events
    resources :members
    resources :families
    resources :teams do
      resources :memberships, controller: 'teams/memberships'
      resources :events, controller: 'teams/events'

      get '/teams/:team_id/membership/:id/promute', to: 'teams/memberships#promute', as: :promute_membership
      get '/teams/:team_id/membership/:id/destitute', to: 'teams/memberships#destitute', as: :destitute_membership
    end
    resources :users do
      get '/invite', to: 'users#invite', as: :invite
      resources :events, controller: 'users/events'
    end
  end

  get '/mon-planning/:user_id', to: 'schedules#index', as: :schedule
  root to: redirect('/users/sign_in')

end
