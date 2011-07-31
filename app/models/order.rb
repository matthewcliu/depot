class Order < ActiveRecord::Base

  has_many :line_items, :dependent => :destroy
  
  PAYMENT_TYPES = ["Check", "Credit card", "Purchase order"]
  validates :name, :address, :email, :pay_type, :presence => true
  validates :pay_type, :inclusion => PAYMENT_TYPES
    
  def add_line_items_from_cart(cart)
    cart.line_items.each do |line_item_import|
      #As an item in the cart is being transferred, set it to nil so it is not erroneous
      line_item_import.cart_id = nil
      #Appends the imported line item to order.line_items
      #Rails handles the foreign key fields, so we don't need to explicitly call them
      line_items << line_item_import
    end
  end
  
end
