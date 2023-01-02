class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :following_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followed_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  has_many :followed_users, through: :followed_relationships, source: :follower
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { minimum: 1, maximum: 30 }, on: :update

  scope :search_by, -> (search_params) {
    search_method = search_params[:search_method]
    search_query = search_params[:search_query]
    return if search_method.blank?
    
    case search_method
    when 'perfect'
      where(name: search_query).
      or(User.where(introduction: search_query))
    when 'prefix'
      where('name LIKE ?', "#{search_query}%").
      or(User.where('introduction LIKE ?', "#{search_query}%"))
    when 'suffix'
      where('name LIKE ?', "%#{search_query}").
      or(User.where('introduction LIKE ?', "%#{search_query}"))
    when 'partial'
      where('name LIKE ?', "%#{search_query}%").
      or(User.where('introduction LIKE ?', "%#{search_query}%"))
    end
  }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def follow(followed_id)
    self.following_relationships.create!(followed_id: followed_id)
  end

  def unfollow(followed_id)
    self.following_relationships.find_by(followed_id: followed_id).destroy!
  end

  def following?(followed_id)
    self.following_users.find_by(id: followed_id).present?
  end
end
