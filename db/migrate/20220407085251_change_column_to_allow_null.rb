class ChangeColumnToAllowNull < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :email,:string, null: true
  end

  def down
    change_column :users, :email,:string, null: false
  end
end
