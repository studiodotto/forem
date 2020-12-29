require 'rails_helper'

RSpec.describe "ArtistApplications", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/artist_applications/new"
      expect(response).to have_http_status(:success)
    end
  end

end
