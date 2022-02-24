class Admin::EventsController < Admin::BaseController
  before_action :set_event, only: %i[edit update show destroy]

  def index
    @q = Event.ransack(params[:q])
    @events = @q.result(distinct: true).includes(:game_application).order(created_at: :desc).page(params[:page])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to admin_events_path, success: t('defaults.message.created', item: Event.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Event.model_name.human)
      render :new
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to admin_event_path(@event), success: t('defaults.message.updated', item: Event.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Event.model_name.human)
      render :edit
    end
  end

  def show; end

  def destroy
    @event.destroy!
    redirect_to admin_events_path, success: t('defaults.message.deleted', item: Event.model_name.human)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :event_type, :started_at, :ended_at, :game_application_id)
  end
end
