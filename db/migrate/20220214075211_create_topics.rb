class CreateTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :topics do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description, null: false
      t.integer :priority, null: false, default: 0
      t.datetime :deadline, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
