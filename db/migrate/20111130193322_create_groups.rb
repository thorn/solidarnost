class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :groupName
      t.integer :groupCoeff

      t.timestamps
    end
  end
end
