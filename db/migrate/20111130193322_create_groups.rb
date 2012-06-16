class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string  :name
      t.integer :coeff, default: 0
      t.boolean :for_people, default: false

      t.timestamps
    end
  end
end
