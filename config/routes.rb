Rails.application.routes.draw do
  devise_for :users, only: [:sessions]
  draw :app
  root to: "pages#home"
end
