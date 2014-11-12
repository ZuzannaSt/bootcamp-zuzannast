require 'test_helper'

class ParkingTest < ActiveSupport::TestCase
  def setup
    @outdoor = parking(:outdoor)
    @public = parking(:public)
    @private = parking(:private)
    @year = place_rents(:year)
  end

  test "should save parking" do
    assert @outdoor.valid?
    assert @outdoor.errors[:places].empty?
    assert @outdoor.errors[:hour_price].empty?
    assert @outdoor.errors[:day_price].empty?
    assert @outdoor.errors[:kind].empty?
  end

  test "should not save parking without places" do
    @outdoor.places = nil
    assert @outdoor.invalid?
    assert_not @outdoor.errors[:places].empty?
  end

  test "should not save parking without kind" do
    @outdoor.kind = nil
    assert @outdoor.invalid?
    assert_not @outdoor.errors[:kind].empty?
  end

  test "should not save parking without hour_price" do
    @outdoor.hour_price = nil
    assert @outdoor.invalid?
    assert_not @outdoor.errors[:hour_price].empty?
  end

  test "should not save parking without day_price" do
    @outdoor.day_price = nil
    assert @outdoor.invalid?
    assert_not @outdoor.errors[:day_price].empty?
  end

  test "should have numeric hour_price" do
    @outdoor.hour_price = "lalala"
    assert @outdoor.invalid?
    assert_not @outdoor.errors[:hour_price].empty?
  end

  test "kind should have value from list" do
    @outdoor.kind = "something"
    assert @outdoor.invalid?
  end

  test "should set end_date before destroying" do
    @outdoor.destroy
    assert_in_delta(Time.now, @year.reload.end_date, 0.01)
  end

  test "should get a list of all public parkings" do
    assert_equal([@outdoor, @public], Parking.public_parkings)
  end

  test "should get a list of all private parkings" do
    assert_equal([@private], Parking.private_parkings)
  end

  test "should get a list of all parkings in day_price range" do
    assert_equal([@public], Parking.day_price_between(12.00, 20.00))
  end

  test "should get a list of all parkings in hour_price range" do
    assert_equal([@outdoor, @public], Parking.hour_price_between(1.00, 5.00))
  end  

  test "should get a list of all parkings in the given city" do
    assert_equal([@outdoor, @public], Parking.in_city("Brzesko"))
  end
end
