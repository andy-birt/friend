class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id
  has_many :likes
  has_many :comments
  validates :body, presence: true
end
