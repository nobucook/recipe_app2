require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,    "Recipes from Japan"
    assert_equal full_title("Help"),  "Help | Recipes from Japan"
  end
end
