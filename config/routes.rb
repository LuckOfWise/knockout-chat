Rails.application.routes.draw do
  resources :comments, only: %i(index create destroy)
  root 'comments#index'
end
