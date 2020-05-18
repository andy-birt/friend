class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friend_requests
  has_many :accepted_requests, -> { where accepted: true }, class_name: "FriendRequest"
  has_many :friends, through: :accepted_requests, source: :receiver
end
