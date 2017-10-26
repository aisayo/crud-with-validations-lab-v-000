class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find_by(id: params[:id])
  end

  def edit
    @song = Song.find_by(id: params[:id])
  end

  def update
    @song = Song.find_by(id: params[:id])
    @song.update(song_params(:title, :released, :release_year, :artist_name, :genre))
    if @song.valid?
      redirect_to song_path(@song)
    else
      render :edit
    end
  end

    def destroy
      @song = Song.find_by(id: params[:id])
      @song.destroy
      redirect_to songs_url
    end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params(:title, :released, :release_year, :genre, :artist_name))
    if @song.valid?
       @song.save
       redirect_to song_path(@song)
     else
       render :new
     end
  end

  private

    def song_params(*args)
      params.require(:song).permit(*args)
    end
end