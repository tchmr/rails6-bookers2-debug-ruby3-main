class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  has_one :chat_room, dependent: :destroy
  
  scope :get_relationship_for_chat_room, -> (user1, user2) {
    where(follower_id: user1.id, followed_id: user2.id)
    .or(Relationship.where(follower_id: user2.id, followed_id: user1.id))
    .first
  }
end
