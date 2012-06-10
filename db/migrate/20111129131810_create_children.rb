class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :name
      t.date :birthday
      t.integer :health
      t.string :study

      t.timestamps
    end
  end
end
