Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "pages#home"
  # resources :categories, only: :show

  # delete 'attachments/:id', to: 'attachments#destroy', as: :destroy_attachment
  resources :observatories, only: %i[index]
  resources :articles, only: %i[show index]

  get 'dashboard', to: 'dashboard#home', as: :home
  namespace :dashboard do
    resources :articles
    resources :observatories
    resources :categories
    resources :projects do
      resources :methodologies, only: %i[new create]
    end
    resources :methodologies, except: %i[new create]
  end
end
