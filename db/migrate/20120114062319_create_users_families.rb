class CreateUsersFamilies < ActiveRecord::Migration
  def change
    create_table :users_families do |t|
      t.integer :user_id
      t.integer :family_id

      t.timestamps
    end
  end
end
