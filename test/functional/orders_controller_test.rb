require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "requires an item in the cart" do
    #Get empty cart
    get :new
    assert_redirected_to store_path
    assert_equal flash[:notice] => "Your cart is empty"
  end
  
  test "should get new" do
    cart = Cart.create
    #Current cart is the newly created cart
    session[:cart_id] = cart.id
    LineItem.create(:cart => cart, :product => products(:ruby), :price => products(:ruby).price)
    
    #Get cart with fixture data
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, :order => @order.attributes
    end

    assert_redirected_to store_path
  end

  test "should show order" do
    get :show, :id => @order.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @order.to_param
    assert_response :success
  end

  test "should update order" do
    put :update, :id => @order.to_param, :order => @order.attributes
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, :id => @order.to_param
    end

    assert_redirected_to orders_path
  end
end
