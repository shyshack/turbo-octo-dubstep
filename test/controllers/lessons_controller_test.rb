require 'test_helper'

class LessonsControllerTest < ActionController::TestCase
  
  def setup
    @lesson = lessons(:one)
  end
  
  test 'should redirect create when not logged in' do
    assert_no_difference 'Lesson.count' do
      post :create, lesson: { title: 'Lorem ipsum' }
    end
    assert_redirected_to login_url
  end
  
  test 'should redirect update when not logged in' do 
    patch :update, id: @lesson, lesson: { title: 'new title' }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Lesson.count' do
      delete :destroy, id: @lesson
    end
    assert_redirected_to login_url
  end
end
