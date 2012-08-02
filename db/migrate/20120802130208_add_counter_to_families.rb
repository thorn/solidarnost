class AddCounterToFamilies < ActiveRecord::Migration
  def change
    add_column :families, :children_counter, :integer
  end
end
