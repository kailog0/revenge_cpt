require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  context "validi value" do
    it "is valid with a url, user_id and status" do
      task = FactoryBot.build(:task, user_id: @user.id)
      expect(task).to be_valid
    end

    it "is valid with a url which length is less than 256" do
      task = FactoryBot.build(:task, user_id: @user.id, url: "a" * 255)
      expect(task).to be_valid
    end
  end

  context "invalid value" do
    it "is invalid without a url" do
      task = FactoryBot.build(:task, url: nil)
      task.valid?
      expect(task.errors[:url]).to include("can't be blank")
    end

    it "is invalid without a user_id" do
      task = FactoryBot.build(:task, user_id: nil)
      task.valid?
      expect(task.errors[:user]).to include("must exist")
    end

    it "is invalid with a url which length is more than 255" do
      task = FactoryBot.build(:task, user_id: @user.id, url: "a" * 256)
      task.valid?
      expect(task.errors[:url]).to include("is too long (maximum is 255 characters)")
    end

    it "is invalid with a status which is not number" do
      task = FactoryBot.build(:task, status: "char")
      task.valid?
      expect(task.errors[:status]).to include("is not a number")
    end
  end
end
