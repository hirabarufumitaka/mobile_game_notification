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

namespace :event_notification do
  desc 'イベントの通知'
  task event_notification: :environment do
    client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end

    notifications = Notification.joins(:event).where('ended_at >= ?', Time.current).where('started_at <= ?', Time.current)
    notifications.each do |notification|
      event = notification.event
      game = notification.event.game_application
      user = notification.user.authentications
      user.each do |line_user|
        message = {
          type: 'text',
          text: "#{game.name}\n#{event.name}\nが開催されています！\n\n通知一覧はこちら\nhttps://socialgame-event.com/events/notifications"
        }
        client.push_message(line_user.uid, message)
        p "LINE通知:user_id #{line_user.user.id}に送信しました"
      end
    end
  end
end

namespace :notification_destroy do
  desc 'イベントが終了していたら通知から削除'
  task event_notification_destroy: :environment do
    Notification.joins(:event).where('ended_at <= ?', Time.current).delete_all
  end
end
