class EventsController < ApplicationController
  def index
    @q = Event.ransack(params[:q])
    @events = @q.result.order(started_at: :desc).page(params[:page])
  end

  def show
    @event = Event.find_by(id: params[:id])
  end
end
