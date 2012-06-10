class RemoveHomeCondFromFamilies < ActiveRecord::Migration
  def up
    remove_column :families, :home_cond
  end

  def down
    add_column  :families, :home_cond,  :string
  end
end
