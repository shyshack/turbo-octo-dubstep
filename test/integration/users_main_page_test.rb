require 'test_helper'

class UsersMainPageTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  
  def setup 
    @user = users(:ignacy)
    @other_user = users(:pedobear)
  end
  
  test 'main page display' do 
    get user_path(@user) 
    log_in_as(@user)
    assert_redirected_to user_path(@user)
    follow_redirect!
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h3', text: @user.name
    assert_select 'h3>img.gravatar'
    assert_match @user.lessons.count.to_s, response.body
    #binding.pry
    assert_select 'div.pagination'
    @user.lessons.paginate(page: 1).each do |lesson|
      assert_match lesson.title, response.body
    end
  end
  
  test 'should redirect when not admin accessing other users home page' do
    get user_path(@other_user)
    log_in_as(@other_user)
    get user_path(@user)
    assert_redirected_to user_path(@other_user)
  end
  
  test 'should allow admin access and modify other users home page' do
    log_in_as(@user)
    get user_path(@other_user)
    assert_match @other_user.lessons.count.to_s, response.body
    assert_match @other_user.name, response.body
    assert_select 'span.glyphicon-trash'
    assert_select '.users .glyphicon-trash'
    assert_difference 'Lesson.count', -1 do 
      delete lesson_path(@other_user.lessons.first)
    end
  end
end
