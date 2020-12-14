class ApplicationController < ActionController::Base
  before_action :initialize_session
  before_action :load_cart

  # if we want to add an item to the cart has been clicked then add an ID of that product to the session
  def add_to_cart

    id = params[:id].to_i     #getting the id and converting to an intiger
    session[:cart] << id      #pushing the id in the session
    redirect_to root_path
    puts(session[:cart])
  end

  # if we want to remove an item from the cart
  def remove_from_cart
    id = params[:id].to_i     #getting the id which has to be removed
    session[:cart].delete(id) #finding an element with id in the cart and removing it
    redirect_to root_path
  end


  private
  #initializing empty session when the browers run
  def initialize_session
    session[:cart] ||= []
  end

  # loading the cart with a menu item based on the same ID from the session
  def load_cart
     @cart = Menu.find(session[:cart])
  rescue ActiveRecord::RecordNotFound
    session[:cart] = []
     # puts(session[:cart])
     # puts(@cart)
  end

end
