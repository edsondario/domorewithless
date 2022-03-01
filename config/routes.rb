Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'afastamentos/', to: 'afastamentos#index'
  post 'afastamentos/', to: 'afastamentos#create'
end
