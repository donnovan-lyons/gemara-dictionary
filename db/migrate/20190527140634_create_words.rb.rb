class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :hebrew
      t.string :translation_one
      t.string :translation_two
      t.string :translation_three
      t.integer :table_id
    end
  end
end
