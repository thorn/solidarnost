class CreateCoefficients < ActiveRecord::Migration
  def change
    create_table :coefficients do |t|
      t.integer :coefficientable_id
      t.string  :coefficientable_type
      t.integer :group_option_id

      t.timestamps
    end
  end
end
