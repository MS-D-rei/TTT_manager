class Team < ApplicationRecord
  has_many :topics, dependent: :destroy
  belongs_to :leader, class_name: 'User', foreign_key: :leader_id
  has_many :assigns, dependent: :destroy
  has_many :members, through: :assigns, source: :user
  has_many :tasks, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :leader_id, presence: true
end
