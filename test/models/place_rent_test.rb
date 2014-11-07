require 'test_helper'

class PlaceRentTest < ActiveSupport::TestCase
  def setup
    @hour = place_rents(:hour)
  end

  test "should save place_rent" do
    assert @hour.valid?
    assert @hour.errors[:start_date].empty?
    assert @hour.errors[:end_date].empty?
    assert @hour.errors[:parking].empty?
    assert @hour.errors[:car].empty?
   end

  test "should not save place_rent without start_date" do
    @hour.start_date = nil
    assert @hour.invalid?
    assert_not @hour.errors[:start_date].empty?
  end

  test "should not save place_rent without end_date" do
    @hour.end_date = nil
    assert @hour.invalid?
    assert_not @hour.errors[:end_date].empty?
  end

  test "should not save place_rent without parking" do
    @hour.parking = nil
    assert @hour.invalid?
    assert_not @hour.errors[:parking].empty?
  end

  test "should not save place_rent without car" do
    @hour.car = nil
    assert @hour.invalid?
    assert_not @hour.errors[:car].empty?
  end
end
