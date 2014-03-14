require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  fixtures :all
  setup do
    # build an order with one line_item
    @order = orders(:one)
    @cart = carts(:one)
    @line_item = @cart.add_product(products(:ruby).id)
    @order.line_items << @line_item
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should redirect to store with notice if try to create new order with no line_items" do
    @order = orders(:empty)
    get :new
    assert_redirected_to store_url
    assert_equal "Your cart is empty", flash[:notice]
  end
  
  # test "should create new order with valid line_items" do
  #   # try again when relationships are added
  #   @order.add_line_items_from_cart(@cart)
  #   get :new
  #   assert_response :success
  # end
  
  test "should create order" do
    assert_difference('Order.count', 1) do
      post :create, order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type }
    end

    assert_redirected_to store_path
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
  
  test "requires item in cart" do
    get :new
    assert_redirected_to store_path
    assert_equal flash[:notice], 'Your cart is empty'
  end
  
  test "should get new" do
    item = LineItem.new
    item.build_cart
    item.product = products(:ruby)
    item.save!
    session[:cart_id] = item.cart.id
    get :new
    assert_response :success
  end
end
