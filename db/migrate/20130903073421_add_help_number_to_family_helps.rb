class AddHelpNumberToFamilyHelps < ActiveRecord::Migration
  def change
    add_column :family_helps, :help_number, :integer, default: 1
  end
end
