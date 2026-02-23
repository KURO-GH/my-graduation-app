# app/models/habit.rb
class Habit < ApplicationRecord
  belongs_to :user
  has_one :study_log, dependent: :destroy  # 1つの投稿に1つのHabit
end
