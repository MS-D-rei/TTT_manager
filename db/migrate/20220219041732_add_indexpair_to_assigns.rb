class AddIndexpairToAssigns < ActiveRecord::Migration[6.0]
  def change
    add_index :assigns, %i[user_id team_id], unique: true
  end
end
