require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
    @valid_product = {title: "Test title",
                description: "Product description",
                image_url: "test.gif",
                price: 20.00 }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
    
    assert_select 'tr', equals: 4 #four items in test database
    assert_select 'dt', "Programming Ruby 1.9" # one of the titles in the test database
    assert_select '.list_actions a', equals: 3 # show, edit and delete links are present
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: @valid_product
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: @valid_product
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end
    assert_redirected_to products_path
  end
  
  test "unauthenticated user should not be able to destroy product" do
    logout
    assert_difference 'Product.count', 0 do
      delete :destroy, id: @product
    end
    assert_redirected_to login_path
  end
end
