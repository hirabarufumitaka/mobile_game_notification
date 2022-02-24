class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|

      t.references :game_application, type: :integer
      t.string :name
      t.text :description
      t.integer :event_type
      t.datetime :started_at, null: false, default: '2000-01-01 00:00:00'
      t.datetime :ended_at, null: false, default: '2000-01-01 01:00:00'

      t.timestamps
    end
  end
end
