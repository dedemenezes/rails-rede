get 'dashboard', to: 'dashboard#home', as: :home
namespace :dashboard do
  resources :conflict_types
  resources :priority_types
  resources :tags, except: :show
  resources :articles, param: :slug
  resources :observatories
  resources :methodologies
  resources :projects
  resources :galleries
  scope module: 'albums' do
    resources :materials, only: %i[index new]
  end
  resources :albums do
    collection do
      get :imagens
    end
    member do
      patch 'update_banner'
    end
  end
  resources :videos
  delete '/attachments/:id', to: 'attachments#destroy', as: :attachment

  namespace :mapbox do
    resources :tilesets
  end
  resources :collaborators
end
