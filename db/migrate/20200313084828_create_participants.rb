class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.string :surname
      t.string :name
      t.string :patronymic
      t.string :project_title
      t.text :project_info
      t.string :organization
      t.string :contact_info
      t.references :nomination, null: false, foreign_key: true

      t.timestamps
    end
  end
end
