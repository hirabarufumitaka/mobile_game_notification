class GameGenre < ApplicationRecord
  has_many :game_application

  validates :name, uniqueness: true, presence: true
end
