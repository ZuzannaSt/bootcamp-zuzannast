require 'test_helper'

class CarsTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset_session!
    log_in
  end

  test "user opens cars index" do
    visit '/cars'
    assert has_content? 'Cars index'
    assert has_content? 'Maluch'
    assert has_content? 'KRK6789'
    assert has_no_content? 'Ferrari'
  end

  test "user opens car details" do
    visit '/cars'
    first( :link, 'Show' ).click
    assert has_content? 'Maluch'
    assert has_content? 'Steve'
  end

  test "user adds a new car" do
    visit '/cars/new'
    assert has_content? 'Cars new'
    fill_in 'model', with: 'Mercedes'
    fill_in 'registration_number', with: 'KRK1234'
    click_button 'Create Car'
    assert has_content? 'Mercedes'
  end

  test "user edits a car" do
    visit '/cars'
    first( :link, 'Edit' ).click
    assert has_content? 'Cars edit'
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
