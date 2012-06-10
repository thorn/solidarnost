class AddInformationToFamiliesMembers < ActiveRecord::Migration
  def change
    add_column :children, :description, :text
    add_column :mothers, :description, :text
    add_column :fathers, :description, :text
    add_column :trusties, :description, :text
    
    add_column :fathers, :phone, :string
    add_column :mothers, :phone, :string
    add_column :trusties, :phone, :string
    add_column :children, :phone, :string

  end
end
