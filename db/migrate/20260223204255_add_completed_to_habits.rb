class AddCompletedToHabits < ActiveRecord::Migration[7.0]
  def change
    add_column :habits, :completed, :boolean, default: false
  end
end
