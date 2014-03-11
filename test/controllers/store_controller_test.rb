require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a', minimum: 4 # sidebar contains 4 links
    assert_select '#main .entry', 4 # four product entries defined by test fixture
    assert_select 'h3', 'Programming Ruby 1.9' # one of the products has this title
    assert_select '.price', /\$[,\d]+\.\d\d/
  end
  
  test "markup needed for store.js.coffee is in place" do
    get :index
    assert_select '.store .entry > img', 4
    assert_select '.entry input[type=submit]', 4
  end
end
