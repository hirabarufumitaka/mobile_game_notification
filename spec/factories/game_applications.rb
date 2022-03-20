FactoryBot.define do
  factory :game_application do
    sequence(:name, "game_application_name_1")
    association :game_genre
  end
end
