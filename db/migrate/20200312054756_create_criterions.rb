class CreateCriterions < ActiveRecord::Migration[6.0]
  def change
    create_table :criterions do |t|
      t.string :title
      t.references :contest, foreign_key: true

      t.timestamps
    end
  end
end
