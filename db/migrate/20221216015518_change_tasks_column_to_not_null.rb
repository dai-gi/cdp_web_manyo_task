class ChangeTasksColumnToNotNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :tasks, :deadline_on, false, Date.new
    change_column_null :tasks, :priority, false, 0
    change_column_null :tasks, :status, false, 0
  end
end
