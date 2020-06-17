require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layouts links" do
    get root_url
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count:3
    assert_select "a[href=?]", about_path, count:2
    assert_select "a[href=?]", contact_path, count:2
    assert_select "a[href=?]", signup_path, count:1
    get contact_path
    assert_select "title", full_title("Contact")

  end

end
