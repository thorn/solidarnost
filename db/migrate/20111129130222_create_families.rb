class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :title
      t.string :phone
      t.integer :city_id
      t.string :address
      t.string :home
      t.string :home_cond
      t.string :square
      t.string :source

      t.timestamps
    end
  end
end
