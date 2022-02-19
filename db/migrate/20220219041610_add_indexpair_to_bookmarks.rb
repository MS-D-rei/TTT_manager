class AddIndexpairToBookmarks < ActiveRecord::Migration[6.0]
  def change
    add_index :bookmarks, %i[user_id task_id], unique: true
  end
end
