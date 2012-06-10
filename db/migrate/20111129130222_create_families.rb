class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string  :title
      t.string  :phone
      t.integer :city_id
      t.string  :address
      t.integer :home_id
      t.integer :source_id
      t.integer :resource_id
      t.text    :description
      t.integer :priority
      t.integer :source_amount

      t.timestamps
    end
  end
end
