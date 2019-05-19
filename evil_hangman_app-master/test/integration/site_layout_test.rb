require 'test_helper'

#Tests the layout of the site to see if the template is correct and the root path or home page can be accessed successfully.
class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
	assert_template 'static_pages/home'
	assert_select "a[href=?]", root_path, count: 2
	assert_select "a[href=?]", about_path
	assert_select "a[href=?]", login_path, count: 2
	assert_select "a[href=?]", signup_path
  end
end
