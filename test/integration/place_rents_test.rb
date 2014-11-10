require 'test_helper'

class PlaceRentsTest < ActionDispatch::IntegrationTest
  test "user opens place_rents index" do
    visit '/place_rents'
    assert has_content? 'Listing rents'
  end

  test "user opens place_rents details" do
    visit '/place_rents'
    first( :link, 'Show' ).click
    assert has_content? 'Place rent'
    assert has_selector? 'td', text: 'Maluch', visible: true
    assert has_link? '<<< Back'
  end

  test "user rents a place" do
    visit '/parkings'
    first( :link, 'RENT').click
    assert has_content? 'New place rent'
    select '2014', from: 'place_rent_start_date_1i'
    select 'November', from: 'place_rent_start_date_2i'
    select '11', from: 'place_rent_start_date_3i'
    select '11', from: 'place_rent_start_date_4i'
    select '30', from: 'place_rent_start_date_5i'
    select '2014', from: 'place_rent_end_date_1i'
    select 'November', from: 'place_rent_end_date_2i'
    select '11', from: 'place_rent_end_date_3i'
    select '15', from: 'place_rent_end_date_4i'
    select '30', from: 'place_rent_end_date_5i'
    select 'Maluch', from: 'place_rent_car_id'
    click_button 'Create Place rent'
    visit place_rent_path(PlaceRent.last)
    assert has_content? 'Maluch'
  end
end
