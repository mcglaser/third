Rails.application.routes.draw do

  get 'address' => 'users#address'

  root 'static_pages#home'

  get 'signup' => 'users#new'

  get 'signup' => 'users#new'

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'
  
  delete 'logout' => 'sessions#destroy'

  resources :users

end