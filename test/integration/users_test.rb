require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset_session!
  end

  test "user name is displayed after logging" do
    visit '/parkings'
    click_link 'Log in'
    fill_in 'email', with: 'steve@jobs.com'
    click_button 'Log in'
    assert has_content? 'Steve Jobs'
    assert has_no_link? 'Log in'
  end

  test "user name is not displayed before logging" do
    visit '/parkings'
    assert has_link? 'Log in'
    assert has_no_content? 'Steve Jobs'
  end

  test "user logs out" do
    log_in
    assert has_content? 'Logged in as Steve Jobs.'
    click_link 'Log out'
    assert has_content? 'Logged out!'
    assert has_link? 'Log in'
    assert has_no_content? 'Steve Jobs'
  end
end
