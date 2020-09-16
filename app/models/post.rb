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
  has_many :notifications, dependent: :destroy

  def like(user)
    likes.create(user_id: user.id)
  end

  def dislike(user)
    like = likes.find_by(user_id: user.id)
    like.destroy
  end

  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: 'like'
    )
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    notification.checked = true if notification.visiter_id == notification.visited_id
    notification.save if notification.valid?
  end

  include JpPrefecture
  jp_prefecture :prefecture_code
end
