require 'rails_helper'

RSpec.describe "UserDocuments", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/user_documents/new"
      expect(response).to have_http_status(:success)
    end
  end

end
