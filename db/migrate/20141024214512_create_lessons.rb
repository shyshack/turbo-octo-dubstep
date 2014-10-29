class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :description
      t.integer :words_qty
      
      t.timestamps
    end
  end
  

  
end
