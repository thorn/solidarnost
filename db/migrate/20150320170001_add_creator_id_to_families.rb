class AddCreatorIdToFamilies < ActiveRecord::Migration
  def change
    add_column :families, :creator_id, :integer
  end
end
