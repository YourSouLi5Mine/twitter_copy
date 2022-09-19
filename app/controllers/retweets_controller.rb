# TODO: I'm not pretty sure about the retweet functionality since I don't use Twitter that much but I tried replicating it by counting the retweets
class RetweetsController < ApplicationController
  before_action :find_tweet

  def create
    if already_retweeted?
      flash[:notice] = "You can't retweet the same post twice"
    else
      @tweet.retweets.create!(user_id: current_user.id)
    end
  end

  private

  def find_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def already_retweeted?
    Retweet.find_by(user_id: current_user.id, tweet_id: params[:tweet_id]).present?
  end
end
