class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find params[:id]
    @films = @list.movies
  end

  def new
  end
end
