class AddScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :score
      t.references :user
      t.timestamps
    end
  end
end
