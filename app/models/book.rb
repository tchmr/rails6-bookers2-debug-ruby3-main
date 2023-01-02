class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  scope :search_by, -> (search_params) {
    search_method = search_params[:search_method]
    search_query = search_params[:search_query]
    return if search_method.blank?

    case search_method
    when 'perfect'
      where(title: search_query).
      or(Book.where(body: search_query))
    when 'prefix'
      where('title LIKE ?', "#{search_query}%").
      or(Book.where('body LIKE ?', "#{search_query}%"))
    when 'suffix'
      where('title LIKE ?', "%#{search_query}").
      or(Book.where('body LIKE ?', "%#{search_query}"))
    when 'partial'
      where('title LIKE ?', "%#{search_query}%").
      or(Book.where('body LIKE ?', "%#{search_query}%"))
    end
  }

  def posted_by?(user)
    self&.user_id == user&.id
  end

  def favorited_by?(user)
    user.favorites.find_by(book: self).present?
  end
end
