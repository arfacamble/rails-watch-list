class ListsController < ApplicationController
  before_action :set_list, only: [:show, :toggle_films]

  def index
    @lists = List.all
    @list = List.new
  end

  def show
    @bookmark = Bookmark.new
    @bookmarks = @list.bookmarks
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def toggle_films
    @films_to_add = Movie.includes(:bookmarks)
                         .where.not(bookmarks: { list_id: @list.id, active: true })
                         .limit(2)
    @films_to_remove = Movie.includes(:bookmarks)
                            .where.not(bookmarks: { list_id: @list.id, active: true })
                            .limit(2)
  end

  private

  def set_list
    @list = List.find params[:id]
  end

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
