class RemoveLineFlagFromEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :line_flag, :boolean
  end
end
