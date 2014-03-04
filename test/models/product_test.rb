require 'test_helper'

class ProductTest < ActiveSupport::TestCase
#  fixtures :products # try commenting this out and see what happens, it shouldn't make any difference because all fixtures are already loaded in test_helper
  
  test "product attributes require title, description, price and image_url to be present" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end
  
  test "price should be a valid positive decimal number" do
    product = valid_product
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
    
    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end
  
  test "title should be unique - I18N" do
    assert products(:ruby) == Product.find_by(title: "Programming Ruby 1.9") #test of fixture data
    product = valid_product
    product.title = "Programming Ruby 1.9"
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end
  
  test "title should be at least ten characters" do
    product = valid_product
    product.title = "short"
    assert product.invalid?
    assert product.errors[:title].any?
    assert_equal ["must be at least 10 characters"], product.errors[:title]
  end
  
  test "image_url should be valid" do
    ok = %w{fred.gif fred.jpg fred.png fred.jpeg FRED.Jpg http://a.b.c/f/d/s/fred.gif}
    bad = %w{fred.doc fred.gif/more fred.gif.more}
    ok.each do |name|
      product = valid_product
      product.image_url = name
      assert product.valid?, "#{name} should be a valid image_url"
    end
    bad.each do |name|
      product = valid_product
      product.image_url = name
      assert product.invalid?
      assert product.errors[:image_url].any?
      assert_equal ["must be a URL for GIF, JPG or PNG image"], product.errors[:image_url]
    end
  end

private
def valid_product
  Product.new(title: "valid_title",
              description: "valid description",
              image_url: "valid.jpg",
              price: 9.99)
  end
end
