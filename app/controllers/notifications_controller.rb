class NotificationsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    if @event.ended_at > Time.current
      current_user.notification(@event)
    else
      flash[:alert] = 'イベントが終了しています'
    end
    redirect_back fallback_location: root_path
  end

  def destroy
    @event = current_user.notifications.find(params[:id]).event
    current_user.unnotification(@event)
  end
end
