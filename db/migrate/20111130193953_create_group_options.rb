class CreateGroupOptions < ActiveRecord::Migration
  def change
    create_table :group_options do |t|
      t.string :name
      t.integer :coeff
      t.references :group

      t.timestamps
    end
    add_index :group_options, :group_id
  end
end
