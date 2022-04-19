class NotificationsController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    current_user.notification(event)
    redirect_back fallback_location: root_path
  end

  def destroy
    event = current_user.notifications.find(params[:id]).event
    current_user.unnotification(event)
    redirect_back fallback_location: root_path
  end
end
