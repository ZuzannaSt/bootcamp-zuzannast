require 'test_helper'

class CarsTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset_session!
    log_in
  end

  test "user opens cars index" do
    visit '/cars'
    assert has_content? 'Your registered cars'
    assert has_content? 'Maluch'
    assert has_content? '2'
  end

  test "user opens car details" do
    visit '/cars'
    first( :link, 'Show' ).click
    assert has_content? 'Maluch'
    assert has_content? 'Steve'
  end

  test "user adds a new car" do
    visit '/cars/new'
    assert has_content? 'New car'
    fill_in 'model', with: 'Mercedes'
    fill_in 'registration_number', with: '3'
    click_button 'Create Car'
    visit car_path(Car.last)
    assert has_content? 'Mercedes'
  end

  test "user edits a car" do
    visit '/cars'
    first( :link, 'Edit' ).click
    assert has_content? 'Editing car'
    assert has_field? 'model', with: 'Maluch'
    fill_in 'model', with: 'Mercedes'
    click_button 'Update Car'
    assert has_content? 'Mercedes'
  end

  test "user removes a car" do
    visit '/cars'
    assert has_content? 'Maluch'
    first( :link, 'Destroy' ).click
    assert has_no_content? 'Maluch'
  end
end
