class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :title
      t.text :description
      t.date :visit_date
      t.integer :family_id

      t.timestamps
    end
  end
end
