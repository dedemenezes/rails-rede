Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "pages#home"
  get '/contact', to: 'pages#contact'
  get '/about_us', to: 'pages#about_us'
  # resources :categories, only: :show

  # delete 'attachments/:id', to: 'attachments#destroy', as: :destroy_attachment
  resources :observatories, only: %i[index show]
  resources :articles, only: %i[show index edit update]
  resources :galleries, only: %i[index show]
  resources :albums, only: %i[index show]
  resources :categories
  resources :tags, only: :show

  namespace :articles do
    namespace :index do
      delete '/tag/:name', to: 'tags#destroy', as: :tag
    end
  end
  # delete 'articles/index/tags', to: 'articles_index_tags#destroy', as: :remove_tag_from_filter

  get 'dashboard', to: 'dashboard#home', as: :home
  namespace :dashboard do
    resources :tags, except: :show
    resources :articles
    resources :observatories
    resources :categories
    resources :projects do
      resources :methodologies, only: %i[new create]
    end
    resources :methodologies, except: %i[new create]
    resources :galleries
    resources :albums do
      member do
        patch 'update_banner'
      end
    end
  end
end
