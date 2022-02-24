class GameApplication < ApplicationRecord
  belongs_to :game_genre
  has_many :events

  validates :name, uniqueness: true, presence: true
end
