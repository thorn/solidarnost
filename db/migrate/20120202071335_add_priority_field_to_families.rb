class AddPriorityFieldToFamilies < ActiveRecord::Migration
  def change
    add_column :families, :priority, :integer
  end
end
