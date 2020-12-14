require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase

  test "should return contact email" do
    mail =   ContactMailer.contact_email("manuelb@gmail.com", "Manuel Bradicic",
      "0745567645", @message = "Hello, this is a test message")
    assert_equal ['info@oldschoolpub.com'], mail.to
    assert_equal ['info@oldschoolpub.com'], mail.from
  end
end
