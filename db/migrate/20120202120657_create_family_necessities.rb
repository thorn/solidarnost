class CreateFamilyNecessities < ActiveRecord::Migration
  def change
    create_table :family_necessities do |t|
      t.integer :family_id
      t.integer :necessity_id

      t.timestamps
    end
  end
end
