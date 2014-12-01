require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  test 'invalid signup information' do
    # visit signup_path
    get signup_path
    # remember User.count, send hash with new user data
    # and check if User.count did not change
    assert_no_difference 'User.count' do 
      post users_path, user: { name: '',
                               email: 'user@invalid',
                               password: "foo",
                               password_confirmation: 'bar' }
    end
     # check if we were redirected to the same place
    assert_template 'users/new'
    assert_select 'ul li', "Name can't be blank"
    assert_select 'ul li', 'Email is invalid'
    assert_select 'ul li', 'Password is too short (minimum is 6 characters)'
    assert_select 'ul li', "Password confirmation doesn't match Password"
  end
  
  test 'valid signup information with account validation' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: { name: 'Raoul Duke',
                               email: 'raoul.duke@example.com',
                               password: 'correctpassword1',
                               password_confirmation: 'correctpassword1' }
      
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    #Try to log in before the activation.
    log_in_as(user)
    assert_not is_logged_in?
    #Invalid activation token
    get edit_account_activation_path('invalid token')
    assert_not is_logged_in?
    #Valid token, wrong email.
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    #Valid activation token.
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
