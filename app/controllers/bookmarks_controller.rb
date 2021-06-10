class BookmarksController < ApplicationController
  before_action :set_list, except: :destroy

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.movie = Movie.find(params[:bookmark][:movie_id])
    @bookmark.list = @list
    @bookmark.active = true
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    list = @bookmark.list_id
    @bookmark.destroy
    redirect_to list_path(list)
  end

  def toggle
    list = List.find params[:list_id]
    film = Movie.find params[:film_id]
    bookmark = Bookmark.where(list: list, movie: film).first
    bookmark.active ? bookmark.update(active: false) : bookmark.update(active: true)
    redirect_to toggle_path(list)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment)
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end
