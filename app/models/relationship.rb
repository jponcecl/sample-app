class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User" # 14.3
  belongs_to :followed, class_name: "User" # 14.3
  validates :follower_id, presence: true # 14.5
  validates :followed_id, presence: true # 14.5
end
