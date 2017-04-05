class SearchController < ApplicationController
  def index
    @searches = Search.all
    render :index
  end

  def create
    article_data = ArticleService.search(key_word[:q])

    if article_data.is_a?(Hash) && article_data[:errors].present?
      flash[:errors] = article_data[:errors]
      redirect_to root_path
    else
      search = Search.find_or_create_by(keyword: key_word[:q])
      search.increment!(:count)

      @searches = Search.all
      @articles = Article.create(article_data)
      render :index
    end
  end

  private

  def key_word
    params.require(:search).permit(:q)
  end
end
