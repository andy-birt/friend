class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id
  has_many :likes
  has_many :comments
  validates :body, presence: true
  scope :paginate, -> (page:, per_page: 5) {
    page = (page || 1).to_i

    current_scope = limit(per_page).offset((page - 1) * per_page)

    Result.new(current_scope).tap do |result|
      result.current_page = page
      result.total_pages = (count / per_page.to_f).ceil
    end
  }

  class Result < SimpleDelegator
    attr_accessor :current_page, :total_pages
  end
end
