Rails.application.routes.draw do
  devise_for :users, only: [:sessions]
  draw :dashboard
  draw :app
  root to: "pages#home"

end
