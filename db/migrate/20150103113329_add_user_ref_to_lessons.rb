class AddUserRefToLessons < ActiveRecord::Migration
  def change
    add_reference :lessons, :user, index: true
  end
end
