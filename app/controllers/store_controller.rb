class StoreController < ApplicationController
  def index
    #Selects all products in the Product table
    @products = Product.all
  end

end
