class AddStudyIdForChidren < ActiveRecord::Migration
  def change
    add_column :children, :study_id, :integer
    remove_column :children, :study
  end
end
