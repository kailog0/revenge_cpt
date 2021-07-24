# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :uid, presence: true
  validates :provider, presence: true

  def self.find_or_create_from_auth_hash!(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    nickname = auth_hash[:info][:nickname]
    User.find_or_create_by!(provider: provider, uid: uid) do |user|
      user.name = nickname
    end
  end

  has_many :tasks
end
