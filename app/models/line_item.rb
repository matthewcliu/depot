class LineItem < ActiveRecord::Base
  #A line item only exists when it is part of a cart
  belongs_to :cart
  #A line item only exists when the corresponding product row exists
  belongs_to :product
  
  #This is the line item local variable total_price, not to be confused with the cart total_price
  def total_price
    product.price * quantity
  end
  
end
