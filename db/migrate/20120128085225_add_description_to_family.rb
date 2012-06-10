class AddDescriptionToFamily < ActiveRecord::Migration
  def change
    add_column :families, :description, :text
  end
end
