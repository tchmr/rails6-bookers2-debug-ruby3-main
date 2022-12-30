class BookComment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  validates :body, presence: true
  
  def posted_by?(user)
    self&.user_id == user&.id
  end
end
