
class Admin::GameApplicationsController < Admin::BaseController

  before_action :set_game_application, only: %i[edit update show destroy]

  def index
    @q = GameApplication.ransack(params[:q])
    @game_applications = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
  end

  def new
    @game_application = GameApplication.new
  end

  def create
    @game_application = GameApplication.new(game_application_params)
    if @game_application.save
      redirect_to admin_game_applications_path, success: t('defaults.message.created', item: GameApplication.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: GameApplication.model_name.human)
      render :new
    end
  end

  def edit; end

  def update
    if @game_application.update(game_application_params)
      redirect_to admin_game_application_path(@game_application), success: t('defaults.message.updated', item: GameApplication.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: GameApplication.model_name.human)
      render :edit
    end
  end

  def show; end

  def destroy
    @game_application.destroy!
    redirect_to admin_game_applications_path, success: t('defaults.message.deleted', item: GameApplication.model_name.human)
  end

  private

  def set_game_application
    @game_application = GameApplication.find(params[:id])
  end

  def game_application_params
    params.require(:game_application).permit(:name, :game_genre_id)
  end
end
