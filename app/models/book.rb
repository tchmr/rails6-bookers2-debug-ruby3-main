class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def posted_by?(user)
    self&.user_id == user&.id
  end
  
  def favorited_by?(user)
    user.favorites.find_by(book: self).present?
  end
end
