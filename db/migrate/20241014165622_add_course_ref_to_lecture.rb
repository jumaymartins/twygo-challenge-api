class AddCourseRefToLecture < ActiveRecord::Migration[7.2]
  def change
    add_reference :lectures, :course, null: false, foreign_key: true
  end
end
