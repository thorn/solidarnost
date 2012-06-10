class AddHelpTypeToFamilyHelps < ActiveRecord::Migration
  def change
    add_column :family_helps, :help_type_id, :integer
  end
end
