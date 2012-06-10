class CreateHelpTypes < ActiveRecord::Migration
  def change
    create_table :help_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
