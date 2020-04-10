class AddCodeToNominations < ActiveRecord::Migration[6.0]
  def change
    add_column :nominations, :code, :string
  end
end
