require "rails_helper"

describe "article" do
  let(:headline) { Faker::Lorem.paragraph }
  let(:url) { Faker::Internet.url }
  let(:paragraph) { Faker::Lorem.paragraph }
  let(:type_of_material) { "News" }
  let(:count) { Faker::Number.number(3) }
  let(:properties) {
    {
      headline: { main: headline },
      web_url: url,
      lead_paragraph: paragraph,
      type_of_material: "News",
      word_count: count
    }
  }

  describe "initialize" do
    it "is initialized with several properties" do
      article = Article.new(properties)

      expect(article.headline).to eq headline
      expect(article.link).to eq url
      expect(article.lead_paragraph).to eq paragraph
      expect(article.article_type).to eq "News"
      expect(article.word_count).to eq count
    end
  end

  describe "create" do
    it "returns an array of articles" do
      result = Article.create([properties, properties, properties])
      expect(result.class).to eq Array
      expect(result.all? { |article| article.class == Article }).to be true
    end
  end
end
