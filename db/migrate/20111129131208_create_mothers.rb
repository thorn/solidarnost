class CreateMothers < ActiveRecord::Migration
  def change
    create_table :mothers do |t|
      t.string :name
      t.date :birthday
      t.integer :health_id
      t.integer :family_id
      t.integer :age
      t.text :description
      t.string :phone

      t.timestamps
    end
  end
end
