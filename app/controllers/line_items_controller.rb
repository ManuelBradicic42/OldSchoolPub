class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]
  before_action :set_order, only: [:create]
  before_action :initialize_session
  # before_action :initialize_value
  before_action :load_cart


  def add_to_session
    id = params[:id].to_i
    session[:cart] << id
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
    array = session[:cart]

    array.each_with_index{ |x,i|
      menu = Menu.find(x)
      @line_item = @order.line_items.build(menu: menu)

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

  # def create
  #   array = session[:cart]
  #   array.each{ |x|
  #     menu = Menu.find(x)
  #     @line_item = @order.line_items.build(menu: menu)
  #     @line_item.save
  #   }
  # end


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



    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def line_item_params
      params.require(:line_item).permit(:order_id, :menu_id)
    end

    def set_order
      @order = Order.find(session[:order_id])
      puts(session[:order_id])
    rescue ActiveRecord::RecordNotFound
      @order = Order.create
      session[:order_id] = @order.id
    end

end
