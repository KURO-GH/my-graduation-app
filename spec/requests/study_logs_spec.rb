require 'rails_helper'

RSpec.describe "StudyLogs", type: :request do
  describe "GET /study_logs" do
    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトされる" do
        get study_logs_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログインしている場合" do
      let(:user) do
        User.create!(
          email: "login@example.com",
          password: "password"
        )
      end

      before do
        sign_in user
      end

      it "正常にアクセスできる" do
        get study_logs_path
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
