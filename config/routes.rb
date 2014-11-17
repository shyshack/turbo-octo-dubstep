Rails.application.routes.draw do
  
  root 'static_pages#home'
  get 'home' => 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup' => 'users#new'

  #get 'welcome/index'

  resources :users
  resources :lessons

  resources :lessons do 
    resources :translations
  end
end
