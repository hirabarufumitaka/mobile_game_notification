class GameApplication < ApplicationRecord
  mount_uploader :game_application_image, GameApplicationImageUploader
  belongs_to :game_genre
  has_many :events

  validates :name, uniqueness: true, presence: true
end
