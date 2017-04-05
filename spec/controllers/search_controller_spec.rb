require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe "get" do
    it "has a 200 status" do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe "post" do
    it "returns a 200 status" do
      post :index
      expect(response.status).to eq 200
    end
  end
end
