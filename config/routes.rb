Rails.application.routes.draw do

  # get 'delivery/index'
  resources :orders
  resources :menus
  resources :line_items

  resources :line_items do
    collection do
      get :createMan
    end
  end

  get 'home', to: 'home#home'
  get 'menu', to: 'menus#menu_display'
  get 'delivery', to: 'delivery#index'
  get 'contact', to: 'home#contact'
  get 'line_show', to: 'line_items#show'
  get 'staff', to: 'home#staff'
  get 'newOrder', to: 'orders#new'

  # get 'add_to_session', to: 'line_items#add_to_session'



  # Adding products to the delivery - seesion
  post 'menus/add_to_cart/:id', to: 'menus#add_to_cart', as: 'add_to_cart'
  # post '/add_to_cart', to: 'line_items#add_to_cart'
  delete 'menus/remove_from_cart/:id', to: 'menus#remove_from_cart', as:'remove_from_cart'

  # Adding method for contact
  post 'request_contact', to: 'home#request_contact'

  root "menus#menu_display"
end
