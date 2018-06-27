Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :genres
  resources :stores
  resources :books
  resources :receipts
  resources :monthlyinputs
  
  get '/graph/linegraph', to: 'graphs#linegraph'
  get '/' , to: 'books#index'
end
