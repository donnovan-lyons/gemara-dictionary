class CreateUserTractates < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tractates do |t|
      t.integer :user_id
      t.integer :tractate_id
    end
  end
end
