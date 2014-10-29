class AddDefaultToLessonWordsQty < ActiveRecord::Migration
  def up
    change_column :lessons, :words_qty, :integer, :default => 0
     
    Lesson.update_all ["words_qty = ?", 0]
  end 
end
