class AddAmountFieldsToGroupOptions < ActiveRecord::Migration
  def change
    add_column :group_options, :amount_start, :integer
    add_column :group_options, :amount_end, :integer
  end
end
