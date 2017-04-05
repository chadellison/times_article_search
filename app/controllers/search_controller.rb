class SearchController < ApplicationController
  def index
    render :index
  end

  def create
    redirect_to root_path
  end

  private

  def search_params
    params.require(:search).permit(:q)
  end
end
