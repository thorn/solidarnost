class CreateFamilyHelps < ActiveRecord::Migration
  def change
    create_table :family_helps do |t|
      t.text    :description
      t.integer :amount
      t.integer :family_id
      t.integer :visit_id
      t.date    :made_at
      t.integer :help_type_id

      t.timestamps
    end
  end
end
