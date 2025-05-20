class CreateSubjects < ActiveRecord::Migration[8.0]
  def change
    create_table :subjects do |t|
      t.string :title, null: false
      t.timestamps
    end
  end
end
