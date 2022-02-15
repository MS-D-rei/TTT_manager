class AddRefTeamToTopics < ActiveRecord::Migration[6.0]
  def change
    add_reference :topics, :team, foreign_key: true
  end
end
