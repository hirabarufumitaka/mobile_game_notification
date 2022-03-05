class EventsController < ApplicationController
  before_action :set_event, only: %i[show]

  def index
    @q = Event.ransack(params[:q])
    @events = @q.result.order(started_at: :desc).page(params[:page])
  end

  def show; end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
