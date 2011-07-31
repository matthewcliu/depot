class StoreController < ApplicationController
  #Whitelist - any user can access these controllers
  skip_before_filter :authorize
  
  def index
    #Selects all products in the Product table
    @products = Product.all
    store_counter_increment
    
    @cart = current_cart
  end
end