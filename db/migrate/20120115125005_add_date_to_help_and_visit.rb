class AddDateToHelpAndVisit < ActiveRecord::Migration
  def change
    add_column :visits, :made_at, :date
    add_column :family_helps, :made_at, :date
  end
end
