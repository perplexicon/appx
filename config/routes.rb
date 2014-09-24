require "monban/constraints/signed_in"

Rails.application.routes.draw do
  constraints Monban::Constraints::SignedIn.new do
    root "dashboards#show", as: :dashboard
  end
  
  root "homes#show"

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :groups, only: [:index, :show]
  resources :sources, only: [:create, :show, :edit, :update, :destroy]
  resources :feed_entries, only: [:destroy]
end
