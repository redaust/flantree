Rails.application.routes.draw do
  get 'analytics/show'
  patch 'links/:id' => 'links#update', as: :links
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  get 'analytics', to: "analytics#show"
  get 'dashboard', to: "dashboard#index"
  get 'appearance', to: "dashboard#appearance"
  get 'donate', to: "dashboard#donate"
  root 'dashboard#index'

# Allows usage of user_path(user) to get URL for a user's profile page.
  get ':id', to: 'dashboard#show', as: :user
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
