class AddActiveToNominations < ActiveRecord::Migration[6.0]
  def change
    add_column :nominations, :active, :boolean, default: true
  end
end
