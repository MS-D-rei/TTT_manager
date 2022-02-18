class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :topics, dependent: :destroy
  has_many :assigns, dependent: :destroy
  has_many :teams, through: :assigns
  has_many :tasks, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
end
