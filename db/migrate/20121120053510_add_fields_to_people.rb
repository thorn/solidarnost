class AddFieldsToPeople < ActiveRecord::Migration
  def change
    add_column :mothers,  :working,    :integer
    add_column :mothers,  :profession, :string
    add_column :fathers,  :working,    :integer
    add_column :fathers,  :profession, :string
    add_column :trusties, :working,    :integer
    add_column :trusties, :profession, :string
    add_column :children, :working,    :integer
    add_column :children, :profession, :string
    add_column :family_members,   :working,    :integer
    add_column :family_members,   :profession, :string
  end
end
