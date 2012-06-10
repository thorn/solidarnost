class CreateFathers < ActiveRecord::Migration
  def change
    create_table :fathers do |t|
      t.string :name
      t.date :birthday
      t.integer :health
      t.boolean :worker

      t.timestamps
    end
  end
end
