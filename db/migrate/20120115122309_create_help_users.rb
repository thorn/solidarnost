class CreateHelpUsers < ActiveRecord::Migration
  def change
    create_table :help_users do |t|
      t.integer :family_help_id
      t.integer :user_id

      t.timestamps
    end
  end
end
