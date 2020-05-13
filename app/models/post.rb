class Post < ApplicationRecord
  belongs_to :user
  mount_uploader :image, PhotoUploader
  default_scope -> { order(created_at: :desc) }
  validates :ramen_name, presence: true
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }
end
