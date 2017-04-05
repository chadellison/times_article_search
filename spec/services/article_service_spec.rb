require "rails_helper"

describe ArticleService do
  describe "search" do
    context "with successful response" do
      # don't actually make api call in test environment
      let(:url) { Faker::Internet.url }
      let(:paragraph) { Faker::Lorem.paragraph }
      let(:name) { Faker::Name.name }
      let(:key_words) { { "keywords" => [ { "name" => name } ] } }

      let(:api_data) {
        {
          "response" => {
            "docs" => [
              "web_url" => url,
              "lead_paragraph" => paragraph,
              "key_words" => key_words,
              "pub_date" => "2017-03-29T00:00:02+0000",
              "type_of_material" => "News",
              "word_count" => "104"
            ]
          }
        }
      }

      it "calls get on httparty with the passed in key word" do
        search_word = Faker::Name.name

        base_uri = "https://api.nytimes.com/svc/search/v2/articlesearch.json?"
        key_word = "q=#{search_word}"
        api_key = nil

        expect(HTTParty).to receive(:get).with(base_uri + key_word + "&api-key=#{api_key}")
          .and_return(api_data)

        ArticleService.search(search_word)
      end
    end

    context "with unsuccessful response" do
      let(:error_message) { { "message" => "Invalid authentication credentials" } }
      let(:key_word) { Faker::Name.name}

      it "returns an errors hash" do
        result = { errors: "Invalid authentication credentials" }
        allow(HTTParty).to receive(:get).and_return error_message
        expect(ArticleService.search(key_word)).to eq result
      end
    end
  end

  describe "base_uri" do
    it "returns the base uri for the new york times article api" do
      result = "https://api.nytimes.com/svc/search/v2/articlesearch.json"
      expect(ArticleService.base_uri).to eq result
    end
  end
end
