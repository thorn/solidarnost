class CreateTrusties < ActiveRecord::Migration
  def change
    create_table :trusties do |t|
      t.string :name
      t.date :birthday
      t.integer :health_id
      t.string :who
      t.integer :family_id
      t.integer :age
      t.text :description
      t.string :phone

      t.timestamps
    end
  end
end
