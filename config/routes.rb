Rails.application.routes.draw do
  get 'home/home'
  resources :menus

  get 'home', to: 'home#home'
  get 'menu', to: 'menus#index'
  get 'destroy', to: 'menus#index_destroy'

  root "home#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
