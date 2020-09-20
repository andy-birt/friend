class Photo < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_one_attached :image
  has_many :likes, as: :likable, dependent: :destroy
  has_many :comments, -> { order(created_at: :asc) }, as: :commentable, dependent: :destroy
  validates :image, content_type: true, size_range: true
end