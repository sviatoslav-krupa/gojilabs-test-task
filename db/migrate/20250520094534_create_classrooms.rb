class CreateClassrooms < ActiveRecord::Migration[8.0]
  def change
    create_table :classrooms do |t|
      t.string :code, null: false
      t.timestamps
    end
  end
end
