class CreateGatherers < ActiveRecord::Migration[5.2]
  def change
    create_table :gatherers do |t|
      t.string :name
      t.date :due_date

      t.timestamps
    end
  end
end
