class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  validates :post_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
