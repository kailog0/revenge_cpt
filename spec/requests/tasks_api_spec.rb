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

  describe 'put /tasks_api' do
    context 'logging in' do
      before do
        @user = FactoryBot.create(:user, provider: "github", uid: "12345")
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
        get "/auth/github/callback"
      end

      it "update task status, updated_at, pre_updated_at and return json" do
        before_update_task = FactoryBot.create(:task, user_id: @user.id)
        put task_path(before_update_task.id), params: { task: { id: before_update_task.id, status: before_update_task.status + 1 }, mode: 'update' }
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(response).to have_http_status(200)
        expect(json["message"]).to include("更新完了しました。")
        after_update_task = Task.find(before_update_task.id)
        expect(after_update_task.status).to be(1)
        expect(after_update_task.pre_updated_at).to eq(before_update_task.updated_at)
        expect(after_update_task.updated_at).not_to eq(before_update_task.updated_at)
      end

      it "downgrade task" do
        # create already updated task
        task = FactoryBot.create(:task, user_id: @user.id)
        first_updated_date = task.updated_at
        task.update(pre_updated_at: task.updated_at, status: 1000 + task.status + 1)

        # update task
        put task_path(task.id), params: { task: { id: task.id, status: task.status - 1 }, mode: 'downgrade' }

        # confirm result
        json = JSON.parse(response.body)
        downgraded_task = Task.find(task.id)
        expect(response).to have_http_status(:success)
        expect(response).to have_http_status(200)
        expect(json["message"]).to include "更新完了しました。"
        expect(downgraded_task.updated_at).to eq(first_updated_date)
      end
    end
  end
end
