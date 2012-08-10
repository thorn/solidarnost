class AddAncestryToCities < ActiveRecord::Migration
  def change
    add_column :cities, :ancestry, :string
    add_column :cities, :aoguid, :string
  end
end
