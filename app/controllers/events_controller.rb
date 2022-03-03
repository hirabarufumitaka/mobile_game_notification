class EventsController < ApplicationController
  def index
    @events = Event.all.order(started_at: :desc).page(params[:page])
  end

  def show
    @event = Event.find_by(id: params[:id])
  end
end
