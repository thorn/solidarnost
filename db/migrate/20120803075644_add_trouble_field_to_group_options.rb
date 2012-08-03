class AddTroubleFieldToGroupOptions < ActiveRecord::Migration
  def change
    add_column :group_options, :trouble, :boolean
  end
end
