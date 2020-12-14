class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]
  before_action :set_order, only: [:create]
  before_action :initialize_session
  # before_action :initialize_value
  before_action :load_cart


  # if we want to add an item to the cart has been clicked then add an ID of that product to the session
  def add_to_cart

    id = params[:id].to_i     #getting the id and converting to an intiger
    session[:cart] << id      #pushing the id in the session
    redirect_to root_path
    puts(session[:cart])
  end

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end


  def add_session
    session[:cart] = params[:array]
  end


  # POST /line_items
  # POST /line_items.json
  def create
    # storing the session in the array

    array = session[:cart]

    #itterating through the array and finiding the element in the menu
    array.each_with_index{ |x,i|
      # fininding the element with an id == x
      menu = Menu.find(x)
      # creating a line_item based on the order id and menu
      @line_item = @order.line_items.build(menu: menu)

      # if each loop is poining on the last element in the session(array)
      if i == array.length()-1
        respond_to do |format|
          if @line_item.save
            format.html { redirect_to @line_item.order, notice: 'Line item was successfully created.' }
            format.json { render :show, status: :created, location: @line_item }
          else
            format.html { render :new }
            format.json { render json: @line_item.errors, status: :unprocessable_entity }
          end
        end
      else
        @line_item.save
      end
    }
  end

  #function which adds a single value to the line_item, not an array of indices
  def createMan
    @lineitem = LineItem.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }

      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to line_items_url, notice: 'Line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

  # initializing the session cart when the page is run.
  def initialize_session
    session[:cart] ||= []
  end

  # def initialize_value
  #   @value ||= Hash.new
  # end

  #fining the prdocut with the id which is stored in the session
  def load_cart
     @cart = Menu.find(session[:cart])
  rescue ActiveRecord::RecordNotFound
    session[:cart] = []
     # puts(session[:cart])
     # puts(@cart)
  end



  # Use callbacks to share common setup or constraints between actions.
  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def line_item_params
    params.require(:line_item).permit(:order_id, :menu_id)
  end

  #creating a session which contains order id, if the new order is created again
  def set_order
    @order = Order.find(session[:order_id])
    puts(session[:order_id])
  #if an error occurs (if the session doesn't exist) - creating a new one.
  rescue ActiveRecord::RecordNotFound
    @order = Order.create
    session[:order_id] = @order.id
  end

end
