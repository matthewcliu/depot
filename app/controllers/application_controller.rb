class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def store_counter_increment
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end
  end
  
  def store_counter_reset
    session[:counter] = nil
  end
  
  private
    #Making current_cart private means it is only available to other controllers since this is the ApplicationController
    def current_cart
      #Function looks in Cart db by :cart_id in the current session to pull cart details and returns
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      #In the case where no existing cart is in place, create a new cart
      cart = Cart.create
      #Assign the newly created cart to the session
      session[:cart_id] = cart.id
      #Return cart
      cart
    end
end
