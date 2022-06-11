class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :number, null: false
      t.integer :messages_count, default: 0
      t.references :application, foreign_key: true, null: false

      t.timestamps

      t.index %i[application_id number], unique: true
    end
  end
end
