require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Recipes | Recipes from Japan"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | Recipes from Japan"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | Recipes from Japan"
  end

end
