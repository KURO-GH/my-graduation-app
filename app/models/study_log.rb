# frozen_string_literal: true

# app/models/study_log.rb
class StudyLog < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true
  validates :category, presence: true  # これを追加
end
