class Group < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_one_attached :image
end
