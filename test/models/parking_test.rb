require 'test_helper'

class ParkingTest < ActiveSupport::TestCase
  def setup
    @outdoor = parking(:outdoor)
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
end
