class CreateFamilyCoeffs < ActiveRecord::Migration
  def change
    create_table :family_coeffs do |t|
      t.belongs_to :family
      t.belongs_to :group_option

      t.timestamps
    end
    add_index :family_coeffs, :family_id
    add_index :family_coeffs, :group_option_id
  end
end
