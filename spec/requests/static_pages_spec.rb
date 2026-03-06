# spec/requests/static_pages_spec.rb
require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /privacy_policy" do
    it "returns http success" do
      get "/privacy_policy"  # ← ここをルートに合わせて修正
      expect(response).to have_http_status(:success)
    end
  end
end
