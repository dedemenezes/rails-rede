get '/contato', to: 'contacts#new', as: :new_contact
post '/contacts', to: 'contacts#create', as: :contacts
get '/sobre', to: 'pages#about_us', as: :about_us
get '/events', to: 'events#index', as: :events
get '/mapa-de-conflitos', to: 'observatories#mapa', as: :mapa_observatories
# delete 'attachments/:id', to: 'attachments#destroy', as: :destroy_attachment
resources :observatories, only: %i[index show], path: "observatorios", param: :name

resources :articles, only: %i[show index edit update], path: 'noticias', param: :header
resources :galleries, only: %i[index show], path: 'acervos', param: :name do
  collection do
    get :documentos
    get :imagens
  end
end
resources :methodologies, only: %i[index show], path: 'metodologias', param: :name
resources :tags, only: :show
resources :albums, only: %i[index show], param: :name

namespace :articles do
  namespace :index do
    delete '/tag/:name', to: 'tags#destroy', as: :tag
  end
end
# delete 'articles/index/tags', to: 'articles_index_tags#destroy', as: :remove_tag_from_filter
