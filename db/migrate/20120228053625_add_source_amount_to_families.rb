class AddSourceAmountToFamilies < ActiveRecord::Migration
  def change
    add_column :families, :source_amount, :integer
  end
end
