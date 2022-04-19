class AddLineFlagToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :line_flag, :boolean, default: false, null: false
  end
end
