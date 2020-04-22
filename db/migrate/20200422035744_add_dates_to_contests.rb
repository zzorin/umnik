class AddDatesToContests < ActiveRecord::Migration[6.0]
  def change
    add_column :contests, :starts_on, :datetime
    add_column :contests, :ends_on, :datetime
  end
end
