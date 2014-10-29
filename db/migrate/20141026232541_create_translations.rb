class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.string :first_language
      t.string :second_language
      t.string :tip
      t.string :example
      t.references :lesson, index: true

      t.timestamps
    end
  end
end
