class AddQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :content
      t.references :author
      t.timestamps
    end
  end
end
