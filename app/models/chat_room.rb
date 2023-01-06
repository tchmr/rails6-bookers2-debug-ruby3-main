class ChatRoom < ApplicationRecord
  belongs_to :relationship
  has_many :messages, dependent: :destroy
end
