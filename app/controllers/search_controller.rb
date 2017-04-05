class SearchController < ApplicationController
  def index
    render :index
  end

  def create
    article_data = ArticleService.search(key_word[:q])

    if article_data[:errors].present?
      flash[:errors] = article_data[:errors]
      redirect_to root_path
    else
      @articles = Article.create(article_data)
      render :index
    end
  end

  private

  def key_word
    params.require(:search).permit(:q)
  end
end
