class CreateNecessities < ActiveRecord::Migration
  def change
    create_table :necessities do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
