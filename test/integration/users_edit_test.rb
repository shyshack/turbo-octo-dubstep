require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users :ignacy
    @other_user = users :pedobear
  end
  
  test 'unsuccessful edit' do
    log_in_as @user
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path @user, user: { name: '',
                                   email: 'foo@invalid',
                                   password: 'foo',
                                   password_confirmation: 'bar' }
    assert_template 'users/edit'
  end
  
  test 'successful edit with friendly forwarding' do
    get edit_user_path @user 
    log_in_as @user
    assert_redirected_to edit_user_path(@user)
    assert_nil session[:forwarding_url]
    name = 'Jozefina'
    email = 'valid@email.com'
    patch user_path @user, user: { name: name,
                                    email: email,
                                    password: '',
                                    password_confirmation: '' }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end
  
  test 'admin is able to edit user' do
    log_in_as @user
    get edit_user_path @other_user
    assert_template 'users/edit'
    name = 'Puchatek'
    patch user_path @other_user, user: { name: name }
    assert_redirected_to @other_user
    @other_user.reload
    assert_equal @other_user.name, name
  end
  
  test 'standard user is not able to edit other user' do 
    log_in_as @other_user
    get edit_user_path @user
    assert_redirected_to @other_user
    patch user_path @user, user: { name: 'Mothafocka' }
    assert_equal @user.name, @user.reload.name
  end
end
