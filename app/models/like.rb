class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user
  counter_culture :post
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :post_id, uniqueness: { scope: :user_id }
end
