get 'dashboard', to: 'dashboard#home', as: :home
namespace :dashboard do
  resources :conflict_types
  resources :priority_types
  resources :tags, except: :show
  resources :articles
  resources :observatories
  resources :categories
  resources :methodologies
  resources :projects
  resources :galleries
  resources :albums do
    collection do
      get :imagens
      get :documentos
    end
    member do
      patch 'update_banner'
      get :edit_document
    end
  end
  delete '/attachments/:id', to: 'attachments#destroy', as: :attachment

  namespace :mapbox do
    resources :tilesets
  end
end