class NotificationsController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    if event.ended_at > Time.current
      current_user.notification(event)
      redirect_back fallback_location: root_path
    else
      flash[:alert] = "イベントが終了しています"
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    event = current_user.notifications.find(params[:id]).event
    current_user.unnotification(event)
    redirect_back fallback_location: root_path
  end
end
