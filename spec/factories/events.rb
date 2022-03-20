FactoryBot.define do
  factory :event do
    sequence(:name, "event_name_1")
    sequence(:description, "event_description_1")
    event_type { :gacha }
    started_at { 1.week.from_now }
    ended_at { 2.week.from_now }
    association :game_application
  end
end
