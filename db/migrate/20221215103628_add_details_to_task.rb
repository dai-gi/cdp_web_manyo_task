class AddDetailsToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :deadline_on, :date
    add_column :tasks, :priority, :integer
    add_column :tasks, :status, :integer
  end
end
