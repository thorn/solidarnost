class AddCounterToFamilies < ActiveRecord::Migration
  def change
    add_column :families, :children_counter, :integer, default: 0
    add_column :families, :member_counter, :integer, default: 0
    add_column :families, :mother_counter, :integer, default: 0
    add_column :families, :father_counter, :integer, default: 0
  end
end
