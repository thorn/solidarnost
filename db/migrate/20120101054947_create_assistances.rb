class CreateAssistances < ActiveRecord::Migration
  def change
    create_table :assistances do |t|
      t.integer :family_help_id
      t.integer :user_id

      t.timestamps
    end
  end
end
