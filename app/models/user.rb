class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :topics, dependent: :destroy
  has_many :assigns, dependent: :destroy
  has_many :teams, through: :assigns
  has_many :tasks, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_tasks, through: :bookmarks, source: :task

  validates :name, presence: true, length: { maximum: 50 }

  def bookmark(task)
    bookmarked_tasks << task
  end

  def unbookmark(task)
    bookmarked_tasks.destroy(task)
  end

  def bookmark?(task)
    bookmarked_tasks.include?(task)
  end

  def self.guest
    find_or_create_by!(email: 'guest@mail.com') do |user|
      user.name = 'ゲストアドミンユーザー'
      user.email = 'guest@mail.com'
      user.password = SecureRandom.urlsafe_base64
      user.admin = true
    end
  end

  def self.guest_as_normal
    find_or_create_by!(email: 'normal_guest@mail.com') do |user|
      user.name = 'ゲストノーマルユーザー'
      user.email = 'normal_guest@mail.com'
      user.password = SecureRandom.urlsafe_base64
      user.admin = false
    end
  end
end
