class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :notifications, foreign_key: :receiver_id, dependent: :destroy
  has_many :friend_requests, dependent: :destroy
  has_many :accepted_requests, -> { where accepted: true }, class_name: "FriendRequest", dependent: :destroy
  has_many :friends, through: :accepted_requests, source: :receiver
end
