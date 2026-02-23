# app/models/study_log.rb
class StudyLog < ApplicationRecord
  belongs_to :user
  has_one :habit, dependent: :destroy  # 投稿ごとに1つのHabitを持つ

  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true
  validates :category, presence: true
end
