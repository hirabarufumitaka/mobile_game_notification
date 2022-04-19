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

namespace :push_line do
  desc 'プッシュ通知のテスト'
  task test: :environment do
    message = {
      type: 'text',
      text: 'イベントが開催されています！'
    }
    client = Line::Bot::Client.new do |config|
      config.channel_id = ENV['LINE_CHANNEL_ID']
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
    response = client.push_message(ENV['LINE_USER_ID'], message)
    p response
  end
end

namespace :line_profile do
  desc '登録ユーザーのプロフィール取得'
  task profile: :environment do
    client = Line::Bot::Client.new do |config|
      config.channel_id = ENV['LINE_CHANNEL_ID']
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
    response = client.get_profile(ENV['LINE_USER_ID'])
    case response
    when Net::HTTPSuccess
      contact = JSON.parse(response.body)
      p contact['displayName']
      p contact['pictureUrl']
      p contact['statusMessage']
    else
      p "#{response.code} #{response.body}"
    end
  end
end

namespace :event_notification do
  desc 'イベントの通知'
  task event_notification: :environment do
    client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end

    notification_events = Notification.all
    notification_events.each do |notification_event|
      event = Event.find(notification_event.event_id)
      game = GameApplication.find(event.game_application_id)
      line_user = Authentication.where(user_id: notification_event.user_id)
      line_user.each do |user|
        message = {
          type: 'text',
          text: "#{game.name}\n#{event.name}\nが開催されています！\n\n通知一覧はこちら\nhttps://www.socialgame-event.com/events/notifications"
        }
        client.push_message(user.uid, message)
        p "LINE通知:user_id #{user.id}に送信しました"
      end
    end
  end
end
