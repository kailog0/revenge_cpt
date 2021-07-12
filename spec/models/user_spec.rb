require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.build(:user)
  end

  context "valid value" do
    it "is valid with a name which length is less than 31" do
      user = FactoryBot.build(:user, name: "a" * 30)
      expect(user).to be_valid
    end

    it "is valid with a name and password" do
      expect(FactoryBot.build(:user)).to be_valid
    end

    it "is valid with a password which length is less than 31" do
      user = FactoryBot.build(:user, password: "a" * 30)
      expect(user).to be_valid
    end

  end

  context "invalid value" do
    it "is invalid without a name" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a password" do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid whit a name whitch length is more than 30" do
      user = FactoryBot.build(:user, name: "a" * 31)
      expect(user).to_not be_valid
    end

    it "is invalid with a password which length is more than 30" do
      user = FactoryBot.build(:user, password: "a" * 31)
      expect(user).to be_valid
    end
  end
end
