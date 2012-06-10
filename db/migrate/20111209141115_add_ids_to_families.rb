class AddIdsToFamilies < ActiveRecord::Migration
  def change
    remove_column :families, :home
    remove_column :families, :source
    remove_column :families, :resource
    add_column :families, :home_id, :integer
    add_column :families, :source_id, :integer
    add_column :families, :resource_id, :integer

  end
end
