class Event < ApplicationRecord
  belongs_to :game_application, optional: true

  enum event_type: { gacha: 0, collab: 1, others: 2 }

  validates :started_at, presence: true
  validates :ended_at, presence: true
  validate :started_ended_check

  def started_ended_check
    return unless started_at > ended_at

    errors.add(:ended_at, 'は開始日時より遅い時間を選択してください')
  end
end
