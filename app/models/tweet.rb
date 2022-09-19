class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  delegate :email, to: :user

  def likes_count
    likes.count
  end
end
