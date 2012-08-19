class AddAreaIdToFamilies < ActiveRecord::Migration
  def change
    add_column :families, :area_id, :integer
  end
end
