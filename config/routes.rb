Rails.application.routes.draw do


  devise_for :users, controllers: {
    invitations: "users/invitations",
    sessions: "users/sessions"
  }

  get '/creer-un-compte', to: 'users/registrations#new', as: :new_registration
  post '/creer-un-compte', to: 'users/registrations#create', as: :registration

  authenticated :user do
    get '/structure/:encrypted_id', to: 'structures#show', as: :connect

    # APP
    namespace :app, path: '' do
      constraints(:subdomain => /app/) do
        root to: 'pages#home', as: :home

      end
    end


    root to: 'structures#index', as: :structures #get user structure



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

  # RGPD
  namespace :public do
    root to: 'pages#home'

    post '/members', to: 'members#create', as: :members
    get '/informations-personnelles', to: 'members#show', as: :member
    get '/informations-personnelles/modifier', to: 'members#edit', as: :edit_member
    patch '/informations-personnelles/modifier', to: 'members#update', as: :update_member
  end

  get '/mon-planning/:user_id', to: 'schedules#index', as: :schedule
  root to: redirect('/users/sign_in')

end
