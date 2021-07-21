require 'rails_helper'

RSpec.describe "TasksApis", type: :request do
  describe "GET /tasks_apis" do
    context "logging in" do
      before do
        @user = FactoryBot.create(:user, provider: "github", uid: "12345")
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
        get "/auth/github/callback" 
      end

      it "return tasks json" do
        FactoryBot.create(:task, user_id: @user.id, updated_at: Time.zone.now - 7.day)
        FactoryBot.create(:task, user_id: @user.id, updated_at: Time.zone.now - 6.day)
        FactoryBot.create(:task, user_id: @user.id, updated_at: Time.zone.now - 5.day)
        get tasks_path, params: { user_id: @user.id, solved_status: 0, from_x_days_ago: 7, to_y_days_ago: 6 }
        expect(response).to have_http_status(200)
        expect(response).to have_http_status(:success)
        json = JSON.parse(response.body)
        expect(json.length).to eq 2
      end

      it "return error json whitout solved_status" do
        get tasks_path, params: { user_id: @user.id, from_x_days_ago: 7, to_y_days_ago: 6 }
        expect(response).to have_http_status(400)
        json = JSON.parse(response.body)
        expect(json["message"]).to include("solved_statusパラメーターを指定してください。")
      end

      it "return error json without from_x_days_ago" do
        get tasks_path, params: { user_id: @user.id, solved_status: 0, to_y_days_ago: 6 }
        expect(response).to have_http_status(400)
        json = JSON.parse(response.body)
        expect(json["message"]).to include("from_x_days_agoパラメーターを指定してください。")
      end

      it "return error json without to_y_days_ago" do
        get tasks_path, params: { user_id: @user.id, solved_status: 0, from_x_days_ago: 7 }
        expect(response).to have_http_status(400)
        json = JSON.parse(response.body)
        expect(json["message"]).to include("to_y_days_agoパラメーターを指定してください。")
      end
    end
  end

  describe 'POST /tasks_api' do
    context 'logging in' do
      before do
        @user = FactoryBot.create(:user, provider: "github", uid: "12345")
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
        get "/auth/github/callback" 
      end

      it "registar task and return json" do
        post tasks_path, params: { task: { url: "https://atcoder.jp/" } }
        json = JSON.parse(response.body)
        expect(json["message"]).to include("登録完了")
        expect(response).to have_http_status(200)
        expect(response).to have_http_status(:success)
      end

      it "return error json with not permitted url" do
        post tasks_path, params: { task: { url: "https://wrong.jp/" } }
        json = JSON.parse(response.body)
        expect(json["messages"]).to include("許可されていないurlです。使い方画面より登録できるurlをご確認ください。")
        expect(response).to have_http_status(400)
      end

      it "return error json when registered url size is upper limit" do
        5000.times do
          FactoryBot.create(:task, user_id: @user.id)
        end
        post tasks_path, params: { task: { url: "https://wrong.jp/" } }
        json = JSON.parse(response.body)
        expect(json["messages"]).to include("タスク登録件数が上限に達したため登録ができませんでした。")
        expect(response).to have_http_status(400)
      end
    end
  end
end
