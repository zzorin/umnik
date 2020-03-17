class CreateMarks < ActiveRecord::Migration[6.0]
  def change
    create_table :marks do |t|
      t.integer :grade, default: 0, null: false
      t.references :criterion, foreign_key: true
      t.references :expert, foreign_key: true
      t.references :participant, foreign_key: true

      t.timestamps
    end
  end
end
