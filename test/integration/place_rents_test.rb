require 'test_helper'

class PlaceRentsTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset_session!
    log_in
  end

  test "user opens place_rents index" do
    visit '/place_rents'
    assert has_content? 'Place_rents index'
  end

  test "user opens place_rents details" do
    visit '/place_rents'
    within "#place_rent_#{place_rents(:hour).id}" do
      click_link 'Show'
    end
    assert has_content? 'Place_rents show'
    assert has_selector? 'td', text: 'Ferrari', visible: true
    assert has_link? '<<< Back'
  end

  test "user rents a place" do
    visit '/parkings'
    first( :link, 'RENT').click
    assert has_content? 'Place_rents new'
    select_date_and_time(DateTime.now, from: 'place_rent_start_date')
    select_date_and_time(DateTime.now + 2.days, from: 'place_rent_end_date')
    select 'Maluch', from: 'place_rent_car_id'
    click_button 'Create Place rent'
    assert has_content? 'Maluch'
  end
end
