require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  test "user name is displayed after logging" do
    visit '/parkings'
    click_link 'Log in'
    visit '/session/new'
    fill_in 'email', with: 'steve@jobs.com'
    click_button 'Submit'
    visit '/parkings'
    has_content? 'Steve Jobs'
    has_no_link? 'Log in'
  end

  test "user name is not displayed before logging" do
    visit '/parkings'
    has_link? 'Log in'
    has_no_content? 'Steve Jobs'
    click_link 'Log in'
  end
end
