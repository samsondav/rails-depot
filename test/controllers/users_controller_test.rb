require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { name: 'sam', password: 'secret', password_confirmation: 'secret' }
    end

    assert_redirected_to users_url
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { name: @user.name, password: 'pass', password_confirmation: 'pass', current_password: 'secret' }
    assert_redirected_to users_url
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
  
  test "should be able to create user without logging in if no users are yet in database" do
    log
    User.delete_all
    assert_difference('User.count') do
      post :create, user: { name: 'sam', password: 'secret', password_confirmation: 'secret' }
    end

    assert_redirected_to users_url
  end
  
  test "should not be able to create user without valid login" do
    logout  
    assert_difference('User.count', 0) do
      post :create, user: { name: 'sam', password: 'secret', password_confirmation: 'secret' }
    end

    assert_redirected_to login_url
  end
end
