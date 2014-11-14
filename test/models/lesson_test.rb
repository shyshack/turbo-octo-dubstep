require 'test_helper'

class LessonTest < ActiveSupport::TestCase

  def setup
    @lesson = Lesson.new(title: "New lesson", description: "New lesson description")
  end
  
  test "Title should not be empty" do 
    @lesson.title = "   "
    assert_not @lesson.valid? 
  end
  
  test "Title should have at least 5 characters" do 
    @lesson.title = "a" * 4
    assert_not @lesson.valid?
  end
  
end
