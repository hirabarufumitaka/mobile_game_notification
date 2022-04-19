class RemoveDescriptionFromEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :description, :text
  end
end
