class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :password
      t.integer :total_score
    end
  end
end
