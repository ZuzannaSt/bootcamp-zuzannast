require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  def setup
    @brzesko = addresses(:brzesko)
  end

  test "should save address" do
    assert @brzesko.valid?
    assert @brzesko.errors[:city].empty?
    assert @brzesko.errors[:street].empty?
    assert @brzesko.errors[:zip_code].empty?
  end

  test "should not save address without city" do
    @brzesko.city = nil
    assert_not @brzesko.valid?
    assert_not @brzesko.errors[:city].empty?
  end

  test "should not save address without street" do
    @brzesko.street = nil
    assert_not @brzesko.valid?
    assert_not @brzesko.errors[:street].empty?
  end

  test "should not save address without zip_code" do
    @brzesko.zip_code = nil
    assert_not @brzesko.valid?
    assert_not @brzesko.errors[:zip_code].empty?
  end
  
  test "should not save address with wrong zip_code" do
    @brzesko.zip_code = "2222222"
    assert_not @brzesko.valid?
  end
end
