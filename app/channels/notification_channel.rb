# app/channels/notification_channel.rb
class NotificationChannel < ApplicationCable::Channel
  def subscribed
    # 現在のユーザー専用のストリームを開始
    stream_from "notification_channel_#{current_user.id}"
  end

  def unsubscribed
    # 必要ならクリーンアップ
  end
end
