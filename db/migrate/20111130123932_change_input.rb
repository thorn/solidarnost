class ChangeInput < ActiveRecord::Migration
  def up
    remove_column :families, :home_condition
    remove_column :families, :square
    add_column    :families, :resource, :integer
    change_column :families, :home, :integer
    change_column :families, :source, :integer
    remove_column :families, :square
    remove_column :fathers, :worker
    remove_column :mothers, :worker
    remove_column :trusties, :worker
  end

  def down
  end
end
