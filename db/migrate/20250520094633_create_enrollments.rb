class CreateEnrollments < ActiveRecord::Migration[8.0]
  def change
    create_table :enrollments do |t|
      t.references :student, null: false
      t.references :section, null: false
      t.timestamps
    end
  end
end
