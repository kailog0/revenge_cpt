# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user

  validates :url, presence: true, length: { maximum: 255 }
  validates :status, presence: true, numericality: true
end
