class CreateJournalEntries < ActiveRecord::Migration
  def change
    create_table :journal_entries do |t|
      t.string :content
      t.integer :user_id
      
      t.timestamps null: false # automatically give timestamps everytime I create, update a model
    end
  end
end
