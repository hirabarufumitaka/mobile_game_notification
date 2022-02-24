class CreateGameApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :game_applications do |t|

      t.belongs_to :game_genre, type: :integer
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
