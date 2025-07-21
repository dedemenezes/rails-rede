get '/contato', to: 'contacts#new', as: :new_contact
post '/contacts', to: 'contacts#create', as: :contacts
get '/sobre', to: 'pages#about_us', as: :about_us
get '/events', to: 'events#index', as: :events
get '/mapa-de-conflitos', to: 'observatories#mapa', as: :mapa_observatories
get '/busca', to: "pages#search", as: :search
# delete 'attachments/:id', to: 'attachments#destroy', as: :destroy_attachment
resources :observatories, only: %i[index show], path: "observatorios", param: :name
get 'acervos/videos_with_modal', to: 'acervos/videos#with_modal', as: :videos_modal

namespace :acervos do
  resources :videos, only: :index, path: 'producoes_audiovisuais'
end

resources :articles, only: %i[show index], path: 'noticias', param: :slug

resources :galleries, only: %i[show], path: 'acervos', param: :name do
  collection do
    resources :materials, path: 'materiais', only: %i[index show], param: :name
    get :imagens
    get :videos
  end
end
resources :methodologies, only: %i[show], path: 'metodologias', param: :slug
resources :tags, only: :show
resources :albums, only: %i[index show], param: :name

namespace :articles do
  namespace :index do
    delete '/tag/:name', to: 'tags#destroy', as: :tag
  end
end


namespace :navbar do
  get "observatories", to: "observatories#index", as: :observatories
  get 'videos', to: 'videos#index', as: :videos
  get 'images', to: 'images#index', as: :images
  get 'materials', to: 'materials#index', as: :materials
  get 'gallery-show/:name', to: 'galleries#show', as: :gallery
end

# delete 'articles/index/tags', to: 'articles_index_tags#destroy', as: :remove_tag_from_filter
