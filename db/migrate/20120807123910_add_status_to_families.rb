class AddStatusToFamilies < ActiveRecord::Migration
  def change
    add_column :families, :status, :integer, default: 1
  end
end
