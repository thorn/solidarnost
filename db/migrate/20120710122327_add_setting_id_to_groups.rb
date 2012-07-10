class AddSettingIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :setting_id, :integer
  end
end
