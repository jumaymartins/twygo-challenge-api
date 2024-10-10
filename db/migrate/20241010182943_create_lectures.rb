class CreateLectures < ActiveRecord::Migration[7.2]
  def change
    create_table :lectures do |t|
      t.string :title
      t.string :references

      t.timestamps
    end
  end
end
