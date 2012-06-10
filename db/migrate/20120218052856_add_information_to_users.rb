class AddInformationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :phone, :string
    add_column :users, :profession, :string
    add_column :users, :description, :text
    add_column :users, :city_id, :integer
  end
end
