class AddPositionToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :position, :integer
    add_column :groups, :hidden, :boolean
  end
end
