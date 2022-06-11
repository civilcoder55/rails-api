class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :number, null: false
      t.text :body, null: false
      t.references :chat, foreign_key: true, null: false

      t.timestamps

      t.index %i[chat_id number], unique: true
    end
  end
end
