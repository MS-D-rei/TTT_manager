class Team < ApplicationRecord
  has_many :topics
  belongs_to :leader, class_name: 'User', foreign_key: :leader_id

  validates :name, presence: true, length: { maximum: 50 }
  validates :leader_id, presence: true
end
