require 'rails_helper'

RSpec.describe "Homes", type: :request do
  let(:valid_search_params) { { search: { query: Faker::Creature::Dog.breed } } }
  let(:invalid_search_params) { { search: { query: nil } } }
  let(:search_url) { "/homes/search" }

  describe "GET /index" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      get "/"
      expect(response).to render_template("index")
    end
  end

  describe "GET /search" do
    context "when the search query is valid" do
      before(:each) do
        get search_url, params: valid_search_params, as: :turbo_stream
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "renders the search template" do
        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
      end
    end

    context "when the search query is invalid" do
      before(:each) do
        get search_url, params: invalid_search_params, as: :turbo_stream
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "renders the search template" do
        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
      end
    end
  end
end
