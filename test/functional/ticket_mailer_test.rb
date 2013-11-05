require 'test_helper'

class TicketMailerTest < ActionMailer::TestCase
  test "updated" do
    mail = TicketMailer.updated
    assert_equal "Updated", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
