class AddAgeFieldToChildren < ActiveRecord::Migration
  def change
    add_column :children, :age, :integer
    add_column :fathers,  :age, :integer
    add_column :mothers,  :age, :integer
    add_column :trusties, :age, :integer
    

  end
end
