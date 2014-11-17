require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    # visit signup_path
    get signup_path
    # remember User.count, send hash with new user data
    # and check if User.count did not change
    assert_no_difference 'User.count' do 
      post users_path, user: { name: "",
                               email: "user@invalid",
                               password: "foo",
                               password_confirmation: "bar" }
    end
     # check if we were redirected to the same place
    assert_template 'users/new'
    assert_select 'ul li', "Name can't be blank"
    assert_select 'ul li', "Email is invalid"
    assert_select 'ul li', "Password is too short (minimum is 6 characters)"
    assert_select 'ul li', "Password confirmation doesn't match Password"
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: "Raoul Duke",
                               email: "raoul.duke@example.com",
                               password: "correctpassword1",
                               password_confirmation: "correctpassword1" }
      
    end
    assert_template 'users/show'
    assert_select 'div.alert-success', "Welcome to turbo octo dictionary!"
  end
end
