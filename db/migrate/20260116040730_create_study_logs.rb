# frozen_string_literal: true

class CreateStudyLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :study_logs do |t|
      t.string :title
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
