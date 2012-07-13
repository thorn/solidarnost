class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string  :name
      t.integer :coeff, default: 0
      t.boolean :for_people, default: false
      t.boolean :important, default: true
      t.integer :setting_id
      t.integer :position
      t.boolean :hidden

      t.timestamps
    end
  end
end
