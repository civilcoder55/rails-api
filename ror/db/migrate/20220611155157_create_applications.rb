class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name, null: false
      t.string :token, null: false
      t.integer :chats_count, default: 0

      t.timestamps

      t.index :token, unique: true
    end
  end
end
