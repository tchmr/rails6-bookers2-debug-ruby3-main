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
  
  def search_by(params)
    search_method = params(:search_method)
    search_word = params(:word)
    return if search_method.blank?
    
    # TODO: LIKEを使って表現する
    # TODO: name, introductionのor検索
    case search_method
    when 'perfect'
      User.where(name: search_word)
    when 'prefix'
      # User.where("name LIKE %")
    when 'suffix'
      # User.where(name: search_word)
    when 'partial'
      # User.where(name: search_word)
  end
end
