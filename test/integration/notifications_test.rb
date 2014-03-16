require 'test_helper'

class SendNotificationOnInvalidCartErrorTest < ActionDispatch::IntegrationTest
  fixtures :orders
  
  test "should send email when updating item ship date" do
    @order = orders(:one)
    # build edit path
    order_one_edit_path = "orders/" + @order.id.to_s
    # build ship date
    t = Time.now
    ship_date_expected = t.httpdate
    # update order to 'shipped' using edit form
    put_via_redirect order_one_edit_path, order: { ship_date: ship_date_expected }
    # check that the date was indeed updated
 #   assert_equal 1, @order.ship_date
    # check that a mail was sent
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["email1@example.com"], mail.to
    assert_equal "Sam's Amazing Online Store Order Confirmation", mail.subject
  end
end
