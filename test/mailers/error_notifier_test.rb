require 'test_helper'

class ErrorNotifierTest < ActionMailer::TestCase
  test "error_occured" do
    # test exception
    e = ActiveRecord::RecordNotFound.new("error.message")
    mail = ErrorNotifier.error_occurred(e)
    assert_equal "Danger, Will Robinson", mail.subject
    assert_equal ["seivadmas@gmail.com"], mail.to
    assert_equal ["admin@depot.com"], mail.from
    assert_match "error.message", mail.body.encoded
  end

end
