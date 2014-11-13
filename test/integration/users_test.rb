require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset_session!
  end

  test "user name is displayed after logging" do
    log_in
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

  test "user logs in directly from main page" do
    log_in
    assert has_content? 'Parkings index'
  end

  test "user logs in after redirection from cars" do
    visit '/cars'
    assert has_content? 'You must be logged in to access this section.'
    click_link 'Log in'
    fill_in 'email', with: 'steve@jobs.com'
    fill_in 'password', with: 'secret123'
    click_button 'Log in'
    assert has_content? 'Cars index'
    assert has_content? 'Maluch'
  end

  test "user logs in after redirection from place_rents" do
    visit '/place_rents'
    assert has_content? 'You must be logged in to access this section.'
    click_link 'Log in'
    fill_in 'email', with: 'steve@jobs.com'
    fill_in 'password', with: 'secret123'
    click_button 'Log in'
    assert has_content? 'Place_rents index'
  end

  test "user registers" do
    visit '/parkings'
    click_link 'Sign in'
    assert has_content? 'Create account'
    fill_in 'first_name', with: 'Tim'
    fill_in 'last_name', with: 'Cook'
    fill_in 'email', with: 'tim@cook.com'
    fill_in 'password', with: 'cooking'
    fill_in 'password_confirmation', with: 'cooking'
    click_button 'Submit'
    assert has_content? 'Account was successfully created.'
  end

  test "user enters wrong confirmation password" do
    visit '/parkings'
    click_link 'Sign in'
    assert has_content? 'Create account'
    fill_in 'password', with: 'cooking'
    fill_in 'password_confirmation', with: 'booking'
    click_button 'Submit'
    assert has_content? "Password confirmation doesn't match Password"
  end

  test "user doesnt enters data to registration fields" do
    visit '/parkings'
    click_link 'Sign in'
    assert has_content? 'Create account'
    click_button 'Submit'
    assert has_content? "Person first name can't be blank"
    assert has_content? "Email can't be blank"
    assert has_content? "Password can't be blank"
  end 

  test "user enters email that is already registered" do
    visit '/parkings'
    click_link 'Sign in'
    assert has_content? 'Create account'
    fill_in 'email', with: 'steve@jobs.com'
    click_button 'Submit'
    assert has_content? 'Email has already been taken'
  end

  test "user receives an email when he registers" do
    visit '/parkings'
    click_link 'Sign in'
    fill_in 'first_name', with: 'Tim'
    fill_in 'last_name', with: 'Cook'
    fill_in 'email', with: 'tim@cook.com'
    fill_in 'password', with: 'cooking'
    fill_in 'password_confirmation', with: 'cooking'
    click_button 'Submit'
    assert_not ActionMailer::Base.deliveries.empty?
    email = ActionMailer::Base.deliveries.last
    assert_equal ['tim@cook.com'], email.to
    assert_equal 'Welcome to Bookparking', email.subject
  end
end
