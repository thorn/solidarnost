class CreateVisitFunds < ActiveRecord::Migration
  def change
    create_table :visit_funds do |t|
      t.integer :fund_id
      t.integer :visit_id

      t.timestamps
    end
  end
end
