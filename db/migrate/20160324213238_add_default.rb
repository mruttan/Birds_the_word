class AddDefault < ActiveRecord::Migration
  def change
    change_column_default(:users, :total_score, 0)
  end
end
