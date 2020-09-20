class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id
  has_many :photos, dependent: :destroy
  accepts_nested_attributes_for :photos, reject_if: proc { |attr| attr["image"].blank? }, allow_destroy: true
  has_many :likes, as: :likable, dependent: :destroy
  has_many :comments, -> { order(created_at: :asc) }, as: :commentable, dependent: :destroy
  validates :body, presence: true, unless: :photo_present?
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

  def photo_present?
    photos.any?
  end
end
