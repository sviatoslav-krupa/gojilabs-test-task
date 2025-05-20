class CreateSections < ActiveRecord::Migration[8.0]
  def change
    create_table :sections do |t|
      t.references :teacher, null: false
      t.references :subject, null: false
      t.references :classroom, null: false
      t.integer :duration_minutes, null: false
      t.time :start_time, null: false
      t.string :weekdays, array: true, default: []
      t.timestamps
    end
  end
end
