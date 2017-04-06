class Article
  attr_reader :headline, :link, :article_type, :word_count, :lead_paragraph

  def initialize(properties = {})
    @headline = properties[:headline][:main]
    @link = properties[:web_url]
    @lead_paragraph = properties[:lead_paragraph]
    @article_type = properties[:type_of_material]
    @word_count = properties[:word_count]
  end

  def self.create(article_data)
    article_data.map do |data|
      Article.new(data)
    end
  end
end
