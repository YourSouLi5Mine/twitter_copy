class LikesController < ApplicationController
  before_action :find_tweet

  def create
    if already_liked?
      flash[:notice] = "You can't like the same post twice"
    else
      @tweet.likes.create!(user_id: current_user.id)
    end
  end

  private

  def find_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def already_liked?
    Like.find_by(user_id: current_user.id, tweet_id: params[:tweet_id]).present?
  end
end
