class ArticleService
  include HTTParty

  def self.search(key_word)
    response = HTTParty.get("#{base_uri}?q=#{key_word}&api-key=#{ENV["api_key"]}")

    if response["status"] == "OK"
      response.deep_symbolize_keys[:response][:docs]
    else
      # handle errors
      { errors: response.deep_symbolize_keys[:message] }
    end
  end

  def self.base_uri
    "https://api.nytimes.com/svc/search/v2/articlesearch.json"
  end
end
