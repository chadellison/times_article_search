class ArticleService
  include HTTParty

  def self.search(key_word)
    # handle errors
    HTTParty.get("#{base_uri}?q=#{key_word}&api-key=#{ENV["api_key"]}")
      .deep_symbolize_keys[:response][:docs]
  end

  def self.base_uri
    "https://api.nytimes.com/svc/search/v2/articlesearch.json"
  end
end
