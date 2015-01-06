
Rails.application.routes.draw do
  
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  root 'static_pages#home'
  get 'home' => 'users#show'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :account_activations, only: [:edit]
  resources :password_resets, only:[:new, :create, :edit, :update]
  resources :users
  resources :lessons, only: [:create, :update, :destroy]

  resources :lessons do 
    resources :translations
  end
end
