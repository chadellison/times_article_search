class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.string :keyword
      t.integer :count, default: 0 
      t.timestamps
    end
  end
end
