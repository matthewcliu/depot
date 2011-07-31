class Cart < ActiveRecord::Base
  #A cart can have many line items - when it is destroyed, so are the line items
  has_many :line_items, :dependent => :destroy
  
  def add_product(product_id)
    #Sets current item as the first row in the cart that matches the existing product ID
    current_item = line_items.where(:product_id => product_id).first
    #If item already exists as a line item
    if current_item
      #Updates the line item
      current_item.quantity += 1
    else
      #Builds a new line item
      current_item = line_items.build(:product_id => product_id)
      current_item.price = current_item.product.price
    end
    #Returns current_item
    current_item
  end
  
  def decrement_line_item(line_item)
    #If quantity is 1, destroy the line item
    if line_item.quantity == 1
      line_item.destroy
      false
    #Otherwise decrement the line item
    else
      line_item.quantity -= 1
      line_item.save
      line_item
    end
  end
  
  #This is a local variable total_price, accessible by cart.
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
  
  #Checks for total number of line items in the cart
  def total_items
    line_items.sum(:quantity)
  end
  
end
