Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "pages#home"
  resources :categories, only: :show

  delete 'attachments/:id', to: 'attachments#destroy', as: :destroy_attachment
  resources :observatories, only: %i[index]

  get 'dashboard', to: 'dashboard#home', as: :dashboard
  namespace :dashboard do
    resources :observatories
    resources :categories
    resources :projects do
      resources :methodologies, only: %i[new create]
    end
    resources :methodologies, except: %i[new create]
  end
end
