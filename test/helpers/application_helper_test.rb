require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper

  test "should work" do
    assert_equal "Place rents", humanized_page_title
  end

  private

  def page_title
    "place_rents"
  end
end
