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

  test "user adds new car with a proper picture" do
    visit '/cars/new'
    assert has_content? 'Cars new'
    fill_in 'model', with: 'Mercedes'
    fill_in 'registration_number', with: 'KRK1234'
    attach_file 'image', File.join(Rails.root, '/test/fixtures/proper-yaris.jpg')
    click_button 'Create Car'
    assert has_selector? 'div.image'
  end

  test "user adds new car with a picture" do
    visit '/cars/new'
    assert has_content? 'Cars new'
    fill_in 'model', with: 'Mercedes'
    fill_in 'registration_number', with: 'KRK1234'
    attach_file 'image', File.join(Rails.root, '/test/fixtures/proper-yaris.jpg')
    click_button 'Create Car'
    assert has_selector? 'div.image'
  end

  test "user adds a car with too big picture" do
    visit '/cars/new'
    fill_in 'model', with: 'Mercedes'
    fill_in 'registration_number', with: 'KRK1234'
    attach_file 'image', File.join(Rails.root, '/test/fixtures/too-big-yaris.jpg')
    click_button 'Create Car'
    assert has_content? 'Image is too long'
  end

  test "user edits a car and adds a picture" do
    visit '/cars'
    first( :link, 'Edit' ).click
    assert has_field? 'model', with: 'Maluch'
    attach_file 'image', File.join(Rails.root, '/test/fixtures/proper-yaris.jpg')
    click_button 'Update Car'
    assert has_selector? 'div.image'
  end

  test "user edits a car, adds and removes a picture" do
    visit '/cars'
    first( :link, 'Edit' ).click
    attach_file 'image', File.join(Rails.root, '/test/fixtures/proper-yaris.jpg')
    click_button 'Update Car'
    click_link 'Edit'
    check 'remove'
    assert has_no_selector? 'div.image'
  end
end
