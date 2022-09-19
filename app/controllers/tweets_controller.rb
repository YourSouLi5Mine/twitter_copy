class TweetsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: tweets }
    end
  end

  def create
    Tweet.create!(content: tweet_params[:content], user: current_user)
    render :index
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content)
  end

  def tweets
    Tweet.includes(:user).order(created_at: :desc).as_json(
      only: [:id, :content, :created_at],
      methods: [:email, :likes_count, :retweets_count]
    )
  end
end
