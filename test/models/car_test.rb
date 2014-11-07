require 'test_helper'

class CarTest < ActiveSupport::TestCase
  def setup
  	@maluch = cars(:maluch)
  end

  test "should save car" do
    assert @maluch.valid?
    assert @maluch.errors[:model].empty?
    assert @maluch.errors[:registration_number].empty?
    assert @maluch.errors[:owner].empty?
  end

  test "should not save car without model" do
  	@maluch.model = nil
  	assert_not @maluch.valid?
  	assert_not @maluch.errors[:model].empty?
  end

  test "should not save car without registration_number" do
  	@maluch.registration_number = nil
  	assert_not @maluch.valid?
  	assert_not @maluch.errors[:registration_number].empty?
  end

  test "should not save car without owner" do
    @maluch.owner = nil
    assert_not @maluch.valid?
    assert_not @maluch.errors[:owner].empty?
  end
end
