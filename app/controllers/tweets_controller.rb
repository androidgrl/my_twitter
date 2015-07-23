class TweetsController < ApplicationController
  def create
    current_user.twitter_client.update(params[:tweet])
    redirect_to root_path
  end

  def favorite_the_tweet
    thing = params[:tweet_id].to_i
    tweet = current_user.twitter_client.home_timeline.select{|tweet| tweet.id == thing }
    current_user.twitter_client.favorite(tweet)
    redirect_to root_path
  end

end
