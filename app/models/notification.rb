class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :item, optional: true
  belongs_to :comment, optional: true
  belongs_to :visiter, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true
end
