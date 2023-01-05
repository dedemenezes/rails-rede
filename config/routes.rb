Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'dashboard/home'
  devise_for :users
  root to: "pages#home"
  delete 'attachments/:id', to: 'attachments#destroy', as: :destroy_attachment
  get 'dashboard', to: 'dashboard#home', as: :dashboard
  namespace :dashboard do
    resources :categories
    resources :projects do
      resources :methodologies, only: %i[new create]
    end
    resources :methodologies, except: %i[new create]
  end
end
