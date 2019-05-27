class CreateTractates < ActiveRecord::Migration[5.2]
  def change
    create_table :tractates do |t|
      t.string :name
    end
  end
end
