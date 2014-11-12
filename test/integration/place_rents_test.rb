require 'test_helper'

class PlaceRentsTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset_session!
    log_in
  end

  test "user opens place_rents index" do
    visit '/place_rents'
    assert has_content? 'Listing rents'
  end

  test "user opens place_rents details" do
    visit '/place_rents'
    first( :link, 'Show' ).click
    assert has_content? 'Place rent'
    puts page.body
    assert has_selector? 'td', text: 'Maluch', visible: true
    assert has_link? '<<< Back'
  end

  test "user rents a place" do
    visit '/parkings'
    first( :link, 'RENT').click
    assert has_content? 'New place rent'
    select_date_and_time(DateTime.now, from: 'place_rent_start_date')
    select_date_and_time(DateTime.now + 2.days, from: 'place_rent_end_date')
    select 'Maluch', from: 'place_rent_car_id'
    click_button 'Create Place rent'
    visit place_rent_path(PlaceRent.last)
    puts page.body
    assert has_content? 'Maluch'
  end
end
