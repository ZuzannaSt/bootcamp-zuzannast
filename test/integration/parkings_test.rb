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
    assert has_selector? 'td', text: 'Kraków', visible: true
    assert has_link? '<<< Back'
  end

  test "user adds a new parking" do
    visit '/parkings/new'
    assert has_content? 'New parking'
    fill_in 'city', with: 'Kraków'
    fill_in 'zip_code', with: '30-334'
    fill_in 'street', with: 'Komandosów'
    fill_in 'places', with: '20'
    select 'outdoor', from: 'kind'
    fill_in 'hour_price', with: '2.00'
    fill_in 'day_price', with: '12.00'
    click_button 'Submit'
    visit parking_path(Parking.last)
    assert has_content? 'Komandosów'
  end

  test "user edits a parking" do
    visit '/parkings'
    first( :link, 'Edit' ).click
    assert has_content? 'Edit parking'
    assert has_field? 'street', with: 'Komandosów'
    fill_in 'street', with: 'Mickiewicza'
    click_button 'Submit'
    assert has_content? 'Mickiewicza'
  end

  test "user removes a parking" do
    visit '/parkings'
    assert has_content? 'Kraków'
    first( :link, 'Remove' ).click
    assert has_no_content? 'Kraków'
  end
end
