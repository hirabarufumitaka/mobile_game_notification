class EventsController < ApplicationController
  before_action :set_event, only: %i[show]

  def index
    @q = Event.ransack(params[:q])
    @events = @q.result.order(started_at: :desc).page(params[:page])
  end

  def show; end

  def notifications
    return if current_user.blank?
    @notification_events = current_user.notification_events.order(created_at: :desc)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
