class Like < ApplicationRecord
  belongs_to :post
  validates :user_id, presence: true
end
