class SearchController < ApplicationController
  before_action :find_searches
  before_action :check_search_box, only: [:create]
  before_action :find_articles, only: [:create]

  def index
    render :index
  end

  def create
    search = Search.find_or_create_by(keyword: key_word[:q])
    search.increment!(:count)

    render :index
  end

  private

  def check_search_box
    unless key_word[:q].present?
      flash[:errors] = "Please enter a keyword"
      redirect_to root_path
    end
  end

  def find_searches
    @searches = Search.order(created_at: :desc)
  end

  def find_articles
    article_data = ArticleService.search(key_word[:q])

    if article_data.is_a?(Hash) && article_data[:errors].present?
      flash.now[:errors] = article_data[:errors]
      redirect_to root_path
    else
      @articles = Article.create(article_data)
    end
  end

  def key_word
    params.require(:search).permit(:q)
  end
end
