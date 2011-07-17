class CombineItemsInCart < ActiveRecord::Migration
  def self.up
    # replace multiple items for a single product in a cart with a single item
    Cart.all.each do |cart|
      # count the number of each product in the cart
      sums = cart.line_items.group(:product_id).sum(:quantity)
      #At this point a separate temporary array exists with product mapping to summed quantity
      
      sums.each do |product_id, quantity|
        #quantity of items in new array
        if quantity > 1
          #remove individual items in the original cart 
          cart.line_items.where(:product_id => product_id).delete_all
          #replace them with a single item, pulling the sum from quantity in the temporary array
          cart.line_items.create(:product_id => product_id, :quantity => quantity)
        end
      end
    end
  end

  def self.down
    #split items with quantity > 1 into multiple line items
    LineItem.where("quantity>1").each do |lineitem|
      #add individual items "quantity" number of times
      lineitem.quantity.times do
        #Creates a new line item of the same product with quantity 1
        LineItem.create :cart_id =>lineitem.cart_id,
          :product_id => lineitem.product_id, :quantity => 1
      end
      
      #remove original line item that has quantity > 1
      lineitem.destroy
    end
  end
end
