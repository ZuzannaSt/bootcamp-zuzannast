require 'test_helper'

class ParkingsTest < ActionDispatch::IntegrationTest
  test "user opens parkings index" do
    visit '/parkings'
    assert has_content? 'Parkings'
  end

  test "user opens parking details" do
    visit '/parkings'
    first( :link, 'Show' ).click
    assert has_content? 'Show parking'
    assert has_selector? 'td', text: 'Krakow', visible: true
    assert has_link? '<<< Back'
  end

  test "user adds a new parking" do
    visit '/parkings/new'
    assert has_content? 'New parking'
    fill_in 'city', with: 'Krakow'
    fill_in 'zip_code', with: '30-334'
    fill_in 'street', with: 'Komandosow'
    fill_in 'places', with: '20'
    select 'outdoor', from: 'kind'
    fill_in 'hour_price', with: '2.00'
    fill_in 'day_price', with: '12.00'
    click_button 'Submit'
    visit parking_path(Parking.last)
    assert has_content? 'Komandosow'
  end

  test "user edits a parking" do
    visit '/parkings'
    first( :link, 'Edit' ).click
    assert has_content? 'Edit parking'
    assert has_field? 'street', with: 'Komandosow'
    fill_in 'street', with: 'Mickiewicza'
    click_button 'Submit'
    assert has_content? 'Mickiewicza'
  end

  test "user removes a parking" do
    visit '/parkings'
    assert has_content? 'Krakow'
    first( :link, 'Remove' ).click
    assert has_no_content? 'Krakow'
  end

  test "user submits search without any params" do
    visit '/parkings'
    click_button 'Search'
    assert has_content? 'Krakow'
    assert has_content? 'Brzesko'
  end

  test "user searches for parking with given params" do
    visit '/parkings'
    fill_in 'city', with: 'Brzesko'
    fill_in 'max_day_price', with: '20.00'
    fill_in 'max_hour_price', with: '5.00'
    check 'public_parking'
    click_button 'Search'
    assert has_no_content? 'Krakow'
    assert has_content? '100'
  end

  test "user searches for public parkings" do
    visit '/parkings'
    check 'public_parking'
    click_button 'Search'
    assert has_content? 'Brzesko'
    assert has_no_content? 'Krakow'
  end

  test "user searches for private parkings" do
    visit '/parkings'
    check 'private_parking'
    click_button 'Search'
    assert has_content? 'Krakow'
    assert has_no_content? 'Brzesko'
  end

  test "user searches for parkings from given city" do
    visit '/parkings'
    fill_in 'city', with: 'Brzesko'
    click_button 'Search'
    assert has_content? 'Brzesko'
    assert has_no_content? 'Krakow'
  end

  test "user searches for parkings from given day_price range" do
    visit '/parkings'
    fill_in 'min_day_price', with: '15.00'
    fill_in 'max_day_price', with: '40.00'
    click_button 'Search'
    assert has_content? 'Krakow'
  end

  test "user searches for parkings from given hour_price range" do
    visit '/parkings'
    fill_in 'min_hour_price', with: '1.00'
    fill_in 'max_hour_price', with: '5.00'
    click_button 'Search'
    assert has_no_content? 'Krakow'
  end
end
