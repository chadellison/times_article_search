require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe "get" do
    it "has a 200 status" do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe "post" do
    context "with a successful search" do
      let(:key_word) { Faker::Name.name }
      let(:url) { Faker::Internet.url }
      let(:paragraph) { Faker::Lorem.paragraph }
      let(:key_words) { { "keywords" => [ { "name" => key_word } ] } }

      let(:api_data) {
        [
          {
            "web_url" => url,
            "lead_paragraph" => paragraph,
            "key_words" => key_words,
            "pub_date" => "2017-03-29T00:00:02+0000",
            "type_of_material" => "News",
            "word_count" => "104",
            "headline" => { "print_headline" => paragraph }
          }.deep_symbolize_keys
        ]
      }

      it "returns a 200 status" do
        allow(ArticleService).to receive(:search).with(key_word)
          .and_return(api_data)

        post :create, params: { search: { q: key_word } }
        expect(response.status).to eq 200
      end

      context "when a search is on a new keyword" do
        it "creates a new search object" do
          allow(ArticleService).to receive(:search).with(key_word)
            .and_return(api_data)

          expect{ post :create, params: { search: { q: key_word } } }
            .to change{ Search.count }.by(1)

          expect(Search.last.count).to eq 1
        end
      end

      context "when a search is on an old keyword" do
        it "does not create a new search object; it increments the search object's count" do
          search = Search.create(keyword: "word", count: 1)

          allow(ArticleService).to receive(:search).with("word")
            .and_return(api_data)

          expect{ post :create, params: { search: { q: "word" } } }
            .not_to change{ Search.count }

          expect(search.reload.count).to eq 2
        end
      end
    end

    context "with an unsuccessful search" do
      let(:key_word) { Faker::Name.name }
      let(:error_data) { { errors: "This is an error" } }

      it "renders an error message and redirects to the root path" do
        allow(ArticleService).to receive(:search).with(key_word)
          .and_return(error_data)

        post :create, params: { search: { q: key_word } }
        expect(flash[:errors]).to eq "This is an error"
        expect(response.status).to eq 302
      end

      it "does not change the search count" do
        allow(ArticleService).to receive(:search).with(key_word)
          .and_return(error_data)

        expect(Search).not_to receive(:find_or_create_by)
        expect{ post :create, params: { search: { q: key_word } }}
          .not_to change{ Search.count }
      end
    end
  end
end
