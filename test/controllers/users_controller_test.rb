require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:ignacy)
    @other_user = users(:pedobear)
  end
  
  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should redirect from edit when not logged in' do 
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect from update when not logged in' do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test 'should redirect index when not logged in' do
    get :index
    assert_redirected_to login_url
  end
  
  test 'should redirect destroy when not logged in' do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end
  
  test 'should redirect destroy when logged in as non-admin' do
    log_in_as(@other_user) 
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end
  
  test 'should not allow to change admin attribute' do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch :update, id: @other_user, user: { name: @other_user.name,
                                            email: @other_user.email,
                                            admin: true }
    assert_not @other_user.reload.admin?
  end
end
