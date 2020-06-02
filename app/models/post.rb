class Post < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  validates :body, presence: true
end
