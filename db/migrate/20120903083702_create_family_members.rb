class CreateFamilyMembers < ActiveRecord::Migration
  def change
    create_table :family_members do |t|
      t.string  :first_name
      t.string  :second_name
      t.string  :last_name
      t.date    :birthday
      t.integer :health_id
      t.integer :family_id
      t.integer :age
      t.integer :study_id
      t.text    :description
      t.boolean :sex
      t.string  :phone
      t.integer :family_member_type_id

      t.timestamps
    end
  end
end
