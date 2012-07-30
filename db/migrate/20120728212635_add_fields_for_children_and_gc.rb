class AddFieldsForChildrenAndGc < ActiveRecord::Migration
  def up
    add_column :children, :sex, :boolean
    add_column :group_options, :problem, :boolean, default: false
  end

  def down
    remove_column :group_options, :problem
    remove_column :children, :sex
  end
end
