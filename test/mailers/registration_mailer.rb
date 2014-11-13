 require 'test_helper'

class RegistrationMailerTest < ActionMailer::TestCase
  test "welcome email" do
    email = RegistrationMailer.welcome_email('tim@cook.com').deliver
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['hello@bookparking.dev'], email.from
    assert_equal ['tim@cook.com'], email.to
    assert_equal 'Welcome to Bookparking', email.subject
  end
end
