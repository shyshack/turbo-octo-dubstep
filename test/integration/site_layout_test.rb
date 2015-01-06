require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:pedobear)
    @admin_user = users(:ignacy)
  end
  
  test 'layout links for not authenticated user' do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path
  end
  
  test 'layout links for authenticated non-admin user' do
    log_in_as(@user)
    assert_redirected_to user_path(@user)
    get root_path
    assert_select "a[href=?]", user_path(@user), count: 3
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", users_path, text: 'Users', count: 0
  end
  
  test 'layout links for authenticated admin user' do
    log_in_as(@admin_user)
    assert_redirected_to user_path(@admin_user)
    get root_path
    assert_select "a[href=?]", user_path(@admin_user), count: 3
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", users_path, text: 'Users'
  end
end

