require 'rails_helper'

RSpec.describe "TasksApis", type: :request do
  describe "GET /tasks_apis" do
    context "logging in" do
      before do
        @user = FactoryBot.create(:user)
        post login_path, params: { session: { name: @user.name, password: @user.password } }
      end

      it "return tasks json" do
        FactoryBot.create(:task, user_id: @user.id)
        get tasks_path, params: { user_id: @user.id, solved_status: 0 }
        expect(response).to have_http_status(200)
        expect(response).to have_http_status(:success)
        json = JSON.parse(response.body)
        expect(json.length).to eq 1
      end
    end
  end
end
