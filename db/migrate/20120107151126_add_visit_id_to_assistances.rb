class AddVisitIdToAssistances < ActiveRecord::Migration
  def change
    add_column :assistances, :visit_id, :integer
  end
end
