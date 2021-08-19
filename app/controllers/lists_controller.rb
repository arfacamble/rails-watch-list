class ListsController < ApplicationController
  before_action :set_list, only: [:show, :toggle_films]

  def index
    @lists = List.all
    @list = List.new
  end

  def show
    @bookmark = Bookmark.new
    @bookmarks = @list.bookmarks.where(active: true)
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
    @films = Movie.first(5)
    @bookmarks_to_toggle = []
    @films.each do |film|
      if (bookmark = Bookmark.where(movie: film, list: @list).first)
        @bookmarks_to_toggle << bookmark
      else
        @bookmarks_to_toggle << Bookmark.create(movie: film, list: @list, active: false, comment: 'Created by toggle')
      end
    end
  end

  private

  def set_list
    @list = List.find params[:id]
  end

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
