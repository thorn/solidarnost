class CreateMothers < ActiveRecord::Migration
  def change
    create_table :mothers do |t|
      t.string :first_name
      t.string :second_name
      t.string :last_name
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
