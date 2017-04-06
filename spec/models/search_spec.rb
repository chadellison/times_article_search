require 'rails_helper'

describe Search do
  it "validates the presence of a keyword" do
    search = Search.new
    expect(search.valid?).to be false

    search = Search.new(keyword: "")
    expect(search.valid?).to be false

    keyword = Faker::Name.name
    search = Search.new(keyword: keyword)
    expect(search.valid?).to be true
  end
end
