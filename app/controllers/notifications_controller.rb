class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def mark_read
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)

    head :ok
  end
end
