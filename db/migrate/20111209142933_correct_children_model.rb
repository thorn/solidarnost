class CorrectChildrenModel < ActiveRecord::Migration
  def up
    remove_column :children, :health
    add_column :children, :health_id, :integer
    remove_column :fathers, :health
    add_column :fathers, :health_id, :integer
    remove_column :mothers, :health
    add_column :mothers, :health_id, :integer
    remove_column :trusties, :health
    add_column :trusties, :health_id, :integer
  end

  def down
    add_column :children, :health, :integer
    remove_column :children, :health_id
    add_column :fathers, :health, :integer
    remove_column :fathers, :health_id
    add_column :mothers, :health, :integer
    remove_column :mothers, :health_id
    add_column :trusty, :health, :integer
    remove_column :trusty, :health_id
  end
end
