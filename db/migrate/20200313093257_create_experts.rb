class CreateExperts < ActiveRecord::Migration[6.0]
  def change
    create_table :experts do |t|
      t.string :surname
      t.string :name
      t.string :patronymic
      t.references :contest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
