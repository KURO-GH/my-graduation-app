class AddHabitRefToStudyLogs < ActiveRecord::Migration[7.0]
  def change
    add_reference :study_logs, :habit, null: true, foreign_key: true
  end
end
