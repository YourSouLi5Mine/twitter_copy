class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy

  delegate :email, to: :user

  def likes_count
    likes.count
  end

  def retweets_count
    retweets.count
  end
end
