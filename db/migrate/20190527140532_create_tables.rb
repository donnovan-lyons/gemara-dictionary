class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :tables do |t|
      t.string :title
      t.integer :user_id
      t.integer :tractate_id
      t.boolean :public, default: false
    end
  end
end
