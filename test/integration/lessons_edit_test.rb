require 'test_helper'

class LessonsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin_user = users(:ignacy)
    @standard_user = users(:pedobear)
    @lesson = @standard_user.lessons.first
    @different_lesson = @admin_user.lessons.first
  end
  
  test "successful lessons edit" do
    log_in_as(@standard_user)
    get edit_lesson_path(@lesson)
    assert_template 'lessons/edit'
    title = 'how to make kids'
    description = 'detailed video tutorial'
    patch lesson_path(@lesson), lesson: { title: title,
                                           description: description }
    assert_redirected_to @lesson
    @lesson.reload
    assert_equal title, @lesson.title
    assert_equal description, @lesson.description
  end
  
  test "unsuccessful lessons edit" do
    log_in_as(@standard_user)
    get edit_lesson_path(@lesson)
    patch lesson_path(@lesson), lesson: { title: ' ' }
    assert_template 'lessons/edit'
  end
  
  test "editing other users lesson should not be allowed for standard user" do
    log_in_as(@standard_user)
    get edit_lesson_path(@different_lesson)
    patch lesson_path(@different_lesson), lesson: { title: 'this is a great title' }
    assert_redirected_to @standard_user
  end
  
  test "admin should be able to edit other users lessons" do
    log_in_as(@admin_user)
    get edit_lesson_path(@lesson)
    title = 'muahaha, I am admin and I will edit you!'
    patch lesson_path(@lesson), lesson: { title: title }
    assert_redirected_to @lesson
    @lesson.reload
    assert_equal title, @lesson.title
  end
end
