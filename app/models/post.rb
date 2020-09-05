class Post < ApplicationRecord
  belongs_to :user
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  mount_uploader :image, PhotoUploader
  default_scope -> { order(created_at: :desc) }
  validates :ramen_name, presence: true
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }
  validates :ramen_kind, presence: true
  validates :shop_name, presence: true
  validates :star, presence: true
  validates :address, presence: true
  validates :prefecture_code, presence: true
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def like(user)
    likes.create(user_id: user.id)
  end

  def dislike(user)
    like = likes.find_by(user_id: user.id)
    like.destroy
  end

  include JpPrefecture
  jp_prefecture :prefecture_code
end
