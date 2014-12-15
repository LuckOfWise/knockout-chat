Rails.application.routes.draw do
  resources :comments, only: %i(index show create destroy)
  root 'comments#index'
end
