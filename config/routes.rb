Rails.application.routes.draw do

  devise_for :users, controllers: {
    invitations: "users/invitations",
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  resources :associations, only: [:index, :new, :create]

  authenticated :user do

    namespace :association do
      root to: 'pages#home'
      resources :families
      resources :members
      resources :users do
        get '/invite', to: 'users#invite', as: :invite
        resources :events, controller: 'users/events'
      end
      resources :teams do
        resources :memberships, controller: 'teams/memberships'
        resources :events, controller: 'teams/events'

        get '/teams/:team_id/membership/:id/promute', to: 'teams/memberships#promute', as: :promute_membership
        get '/teams/:team_id/membership/:id/destitute', to: 'teams/memberships#destitute', as: :destitute_membership
      end
    end

    resources :events
  end

  namespace :public do
    root to: 'pages#home'

    get '/inscription', to: 'members#new', as: :new_member
    post '/members', to: 'members#create', as: :members
    get '/informations-personnelles', to: 'members#show', as: :member
    get '/informations-personnelles/modifier', to: 'members#edit', as: :edit_member
    patch '/informations-personnelles/modifier', to: 'members#update', as: :update_member
  end

  get '/mon-planning/:user_id', to: 'schedules#index', as: :schedule

  root to: redirect('/public')

end
