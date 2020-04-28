class AddShowResultsToContests < ActiveRecord::Migration[6.0]
  def change
    add_column :contests, :show_results, :boolean, default: false
  end
end
