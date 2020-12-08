Rails.application.routes.draw do
  resources :line_items
  # get 'delivery/index'
  resources :orders
  resources :menus
  resources :line_items
  get 'home/home'

  get 'home', to: 'home#home'
  get 'menu', to: 'menus#menu_display'
  get 'delivery', to: 'delivery#index'
  get 'contact', to: 'home#contact'
  get 'line_show', to: 'line_items#show'
  get 'staff', to: 'home#staff'

  # Adding products to the delivery - seesion
  post 'menus/add_to_cart/:id', to: 'menus#add_to_cart', as: 'add_to_cart'
  delete 'menus/remove_from_cart/:id', to: 'menus#remove_from_cart', as:'remove_from_cart'

  # Adding method for contact
  post 'request_contact', to: 'home#request_contact'



  root "menus#menu_display"
end
