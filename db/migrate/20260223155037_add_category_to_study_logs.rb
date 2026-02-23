class AddCategoryToStudyLogs < ActiveRecord::Migration[7.0]
  def change
    add_column :study_logs, :category, :string
  end
end
