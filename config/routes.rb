Rails.application.routes.draw do
  # get 'delivery/index'
  resources :orders
  get 'home/home'
  resources :menus

  get 'home', to: 'home#home'
  get 'menu', to: 'menus#menu_display'
  get 'delivery', to: 'delivery#index'

  post 'menus/add_to_cart/:id', to: 'menus#add_to_cart', as: 'add_to_cart'
  delete 'menus/remove_from_cart/:id', to: 'menus#remove_from_cart', as:'remove_from_cart'

  root "menus#menu_display"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
