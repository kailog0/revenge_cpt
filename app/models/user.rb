# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: { maximum: 30 }
  validates :password, presence: true, length: { maximum: 80 }

  has_many :tasks
end
