Rails.application.routes.draw do
  get 'dashboard/home'
  devise_for :users
  root to: "pages#home"

  get 'dashboard', to: 'dashboard#home', as: :dashboard
  namespace :dashboard do
    resources :projects
  end
end
