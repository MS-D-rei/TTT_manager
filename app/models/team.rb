class Team < ApplicationRecord
  has_many :topics

  validates :name, presence: true, length: { maximum: 50 }
  validates :leader_id, presence: true
end
