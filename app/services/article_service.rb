class ArticleService
  include HTTParty

  def search(key_word)

    HTTParty.get("#{base_uri}?q=#{key_word}&api-key=#{ENV["api_key"]}")
  end

  def base_uri
    "https://api.nytimes.com/svc/search/v2/articlesearch.json"
  end
end
