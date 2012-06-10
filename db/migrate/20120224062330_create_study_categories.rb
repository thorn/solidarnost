class CreateStudyCategories < ActiveRecord::Migration
  def change
    create_table :study_categories do |t|

      t.timestamps
    end
  end
end
