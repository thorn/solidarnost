class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.integer :setting_id
      t.integer :family_id
      t.string  :type

      t.timestamps
    end
  end
end
