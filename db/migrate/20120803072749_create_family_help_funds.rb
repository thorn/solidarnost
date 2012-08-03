class CreateFamilyHelpFunds < ActiveRecord::Migration
  def change
    create_table :family_help_funds do |t|
      t.integer :family_help_id
      t.integer :fund_id

      t.timestamps
    end
  end
end
