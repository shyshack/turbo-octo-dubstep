class AddLastExcersiseToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :last_excercise, :timestamp
  end
end
