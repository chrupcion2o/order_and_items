Rails.application.routes.draw do
  get 'new' => 'order#new'
  post 'create' => 'order#new'
  get 'index' => 'order#index'
  root 'order#index'
end
