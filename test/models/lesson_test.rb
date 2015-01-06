require 'test_helper'

class LessonTest < ActiveSupport::TestCase

  def setup
    @user = users(:ignacy)
    @lesson = @user.lessons.build(title: 'New lesson', description: 'new lesson description')
  end
  
  test 'should be valid' do
    assert @lesson.valid?
  end
  
  test 'user id should be present' do
    @lesson.user_id = nil
    assert_not @lesson.valid?
  end
  
  test 'Title should not be empty' do 
    @lesson.title = "   "
    assert_not @lesson.valid? 
  end
  
  test 'Title should have at least 5 characters' do 
    @lesson.title = "a" * 4
    assert_not @lesson.valid?
  end
  
  test 'Order should be most recent first' do 
    assert_equal Lesson.first, lessons(:most_recent)
  end
  
end
