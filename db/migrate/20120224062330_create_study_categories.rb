class CreateStudyCategories < ActiveRecord::Migration
  def change
    create_table :study_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
