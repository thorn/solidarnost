class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.text :text
      t.string :title
      t.integer :news_type
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
