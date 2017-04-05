require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe "get" do
    it "has a 200 status" do
      get :index
    end
  end
end
