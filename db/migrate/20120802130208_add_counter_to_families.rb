class AddCounterToFamilies < ActiveRecord::Migration
  def change
    add_column :families, :children_counter, :integer
    add_column :families, :member_counter, :integer
  end
end
