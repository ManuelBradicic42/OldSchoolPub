class ApplicationController < ActionController::Base
  before_action :initialize_session
  # before_action :initialize_value
  before_action :load_cart

  def add_to_cart
    id = params[:id].to_i
    session[:cart] << id
    redirect_to root_path
  end


  # def add_to_cart
  #   id = params[:id].to_i
  #
  #   if @value.has_key?(id)
  #     @value[id] += 1
  #   else
  #     @value[id] = 1
  #   end
  #   puts @value
  #   session[:cart].clear
  #   session[:cart] << @value
  #   redirect_to root_path
  # end

  # def add_to_cart
  #   value ||= Hash.new
  #
  #   id = params[:id].to_i
  #   if($value.has_key?(id))
  #     temp = $value.fetch(id) + 1
  #     $value[id] = temp
  #   else
  #     $value[id] = 1
  #   end
  #   session[:cart] << $value
  #   # session[:cart] << id
  #   redirect_to root_path
  # end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to root_path
  end


  private

  def initialize_session
    session[:cart] ||= []
  end

  # def initialize_value
  #   @value ||= Hash.new
  # end

  def load_cart
     @cart = Menu.find(session[:cart])
  rescue ActiveRecord::RecordNotFound
    session[:cart] = []
     # puts(session[:cart])
     # puts(@cart)
  end

end
