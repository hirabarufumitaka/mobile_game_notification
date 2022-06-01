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
