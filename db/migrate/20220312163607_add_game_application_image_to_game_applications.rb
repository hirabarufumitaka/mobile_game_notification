class AddGameApplicationImageToGameApplications < ActiveRecord::Migration[6.1]
  def change
    add_column :game_applications, :game_application_image, :string
  end
end
