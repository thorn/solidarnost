class AddNameToStudyCategories < ActiveRecord::Migration
  def change
    add_column :study_categories, :name, :string
  end
end
