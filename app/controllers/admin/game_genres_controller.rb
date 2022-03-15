class Admin::GameGenresController < Admin::BaseController
  before_action :set_game_genre, only: %i[edit update show destroy]

  def index
    @q = GameGenre.ransack(params[:q])
    @game_genres = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
  end

  def new
    @game_genre = GameGenre.new
  end

  def create
    @game_genre = GameGenre.new(game_genre_params)
    if @game_genre.save
      redirect_to admin_game_genres_path, success: t('defaults.message.created', item: GameGenre.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: GameGenre.model_name.human)
      render :new
    end
  end

  def edit; end

  def update
    if @game_genre.update(game_genre_params)
      redirect_to admin_game_genre_path(@game_genre), success: t('defaults.message.updated', item: GameGenre.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: GameGenre.model_name.human)
      render :edit
    end
  end

  def show; end

  def destroy
    @game_genre.destroy!
    redirect_to admin_game_genres_path, success: t('defaults.message.deleted', item: GameGenre.model_name.human)
  end

  private

  def set_game_genre
    @game_genre = GameGenre.find(params[:id])
  end

  def game_genre_params
    params.require(:game_genre).permit(:name)
  end
end
