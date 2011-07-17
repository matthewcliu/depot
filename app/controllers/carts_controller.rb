class CartsController < ApplicationController
  # GET /carts
  # GET /carts.xml
  def index
    @carts = Cart.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @carts }
    end
  end

  # GET /carts/1
  # GET /carts/1.xml
  def show
    begin
      @cart = Cart.find(params[:id])
    #If there is no cart that corresponds to the :id entered, intercept the exception
    rescue ActiveRecord::RecordNotFound
      #Adds entry to carts controller under "Error" level
      logger.error "Attempt to access invalid cart #{params[:id]}"
      #:notice automatically stores to flash
      #Note that redirects should go to URLs and not paths formally, but in practice it doesn't matter
      redirect_to store_url, :notice => "Invalid cart"
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @cart }
      end
    end
  end

  # GET /carts/new
  # GET /carts/new.xml
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cart }
    end
  end

  # GET /carts/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end

  # POST /carts
  # POST /carts.xml
  def create
    @cart = Cart.new(params[:cart])

    respond_to do |format|
      if @cart.save
        format.html { redirect_to(@cart, :notice => 'Cart was successfully created.') }
        format.xml  { render :xml => @cart, :status => :created, :location => @cart }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.xml
  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to(@cart, :notice => 'Cart was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.xml
  def destroy
    #Makes sure @cart is the user's current cart - this is actually not robust enough for security but will be a placeholder
    @cart = current_cart
    @cart.destroy
    #Empties session
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to(store_url, :notice => "Your cart is currently empty") }      
      format.xml  { head :ok }
    end
  end
end
