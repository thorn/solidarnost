class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :group_name
      t.string :name
      t.integer :start
      t.integer :end
      t.text :value
      t.integer :amount
      t.date :start_at
      t.date :end_at

      t.timestamps
    end
  end
end
