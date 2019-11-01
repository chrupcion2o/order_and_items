Rails.application.routes.draw do
  get 'new' => 'order#new', as: :new_order
  post 'create' => 'order#create', as: :create_order
  get 'index' => 'order#index', as: :orders
  root 'order#index'
end
