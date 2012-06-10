class AddReferencesToTables < ActiveRecord::Migration
  def change
    add_column  :fathers, :family_id, :integer
    add_column  :mothers, :family_id, :integer
    add_column  :trusties, :family_id, :integer
    add_column  :children, :family_id, :integer
  end
end
