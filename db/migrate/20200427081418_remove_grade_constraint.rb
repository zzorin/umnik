class RemoveGradeConstraint < ActiveRecord::Migration[6.0]
  def change
    change_column_null :marks, :grade, true
    change_column_default :marks, :grade, from: 0, to: nil
  end
end
