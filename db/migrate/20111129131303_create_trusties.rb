class CreateTrusties < ActiveRecord::Migration
  def change
    create_table :trusties do |t|
      t.string :name
      t.date :birthday
      t.integer :health
      t.boolean :worker
      t.string :who

      t.timestamps
    end
  end
end
