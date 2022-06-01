require 'open-uri'
require 'json'

namespace :event_scraping do
  desc 'イベントのスクレイピング処理'
  task get_puroseka_data: :environment do
    puts 'プロセカのイベントデータを取得'
    puroseka_json = URI.open('https://sekai-world.github.io/sekai-master-db-diff/gachas.json').read
    puroseka_hash = JSON.parse(puroseka_json)
    puroseka_events = []
    puroseka_hash.each do |event_hash|
      # データ取得済は保存しない
      next if Event.exists?(scraping: event_hash['id'])

      puroseka_events << Event.new(
        scraping: event_hash['id'],
        # game_application_id = 1はプロセカのID
        game_application_id: 1,
        name: event_hash['name'],
        event_type: 'gacha',
        # JavaScriptからRubyの時間データに変換
        started_at: Time.at(event_hash['startAt'].to_i / 1000.to_f),
        ended_at: Time.at(event_hash['endAt'].to_i / 1000.to_f)
      )
    end
    Event.import puroseka_events
  end
end
