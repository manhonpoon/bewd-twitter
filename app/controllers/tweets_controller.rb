class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all.order(created_at: :desc)
    render 'tweets/index' # can be omitted
  end

  def index_by_user
    user = User.find_by(username: params[:username])
  
    if user
      @tweets = user.tweets.select(:id, :message).map do |tweet|
        {
          id: tweet.id,
          username: user.username,
          message: tweet.message
        }
      end
  
      render json: { tweets: @tweets }
    else
      render json: { tweets: [] }
    end
  end

  def create
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session
      user = session.user
      @tweet = user.tweets.new(tweet_params)

      if @tweet.save
        render 'tweets/create' # can be omitted
      else
        render json: { success: false }
      end
    else
      render json: { success: false }
    end
  end

  def destroy
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)
  
    if session
      @tweet = Tweet.find(params[:id])
      if @tweet.destroy
        render json: { success: true }
      else
        render json: { success: false }
      end
    else
      render json: { success: false }
    end
  end
  

  private

  def tweet_params
    params.require(:tweet).permit(:message)
  end
end
