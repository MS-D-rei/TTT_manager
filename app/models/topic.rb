class Topic < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 200 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :priority, presence: true
  validates :status, presence: true

  enum priority: { high: 0, middle: 1, low: 2 }
  enum status: { not_started: 0, doing: 1, completed: 2 }
end
