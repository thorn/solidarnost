class AddVisitIdToFamilyHelp < ActiveRecord::Migration
  def change
    add_column :family_helps, :visit_id, :integer
  end
end
