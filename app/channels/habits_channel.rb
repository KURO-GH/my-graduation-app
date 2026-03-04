# app/channels/habits_channel.rb
class HabitsChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end

  def unsubscribed
    # ここに必要なクリーンアップ処理があれば書く
  end
end
