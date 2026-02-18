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

  describe "POST /study_logs" do
    context "ログインしていない場合" do
      it "投稿できない" do
        post study_logs_path, params: {
          study_log: { title: "test", content: "content" }
        }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログインしている場合" do
      let(:user) { User.create!(email: "user@example.com", password: "password") }

      before { sign_in user }

      it "投稿が作成される" do
        expect {
          post study_logs_path, params: {
            study_log: { title: "test", content: "content" }
          }
        }.to change(StudyLog, :count).by(1)
      end
    end
  end

  describe "GET /study_logs/:id/edit" do
    context "他人の投稿を編集しようとした場合" do
      let(:owner) { User.create!(email: "owner@example.com", password: "password") }
      let(:other_user) { User.create!(email: "other@example.com", password: "password") }
      let(:study_log) { StudyLog.create!(title: "test", content: "content", user: owner) }

      before { sign_in other_user }

      it "RecordNotFoundが発生する" do
  expect {
    get edit_study_log_path(study_log)
  }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

end
