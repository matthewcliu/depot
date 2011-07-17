class LineItemsController < ApplicationController
  # GET /line_items
  # GET /line_items.xml
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.xml
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.xml
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.xml
  def create
    #We want to show a button when creating a new line_item in a cart, referencing a product
    #Selects current cart, or creates a new one if nil (see Application Controller)
    @cart = current_cart
    #product is the current product being viewed in the browser - params pulls it from the browser
    #This is stored in a local variable and not an instance variable because it doesn't need to be accessed by the view
    product = Product.find(params[:product_id])
    #@line_item is an element within the current cart, and has the current product in the product column
    #The relationship is built on both ends. No need to create this from the product controller
    #Calls add_product method that creates a new line item or adds to the quantity of an existing one
    @line_item = @cart.add_product(product.id)
    
    #Reset the store counter
    store_counter_reset
    
    respond_to do |format|
      if @line_item.save
        #Changes the redirect to the current cart that the current line item has been saved to
        format.html { redirect_to(@line_item.cart) }
        format.xml  { render :xml => @line_item, :status => :created, :location => @line_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.xml
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to(@line_item, :notice => 'Line item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.xml
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to(line_items_url) }
      format.xml  { head :ok }
    end
  end
end
