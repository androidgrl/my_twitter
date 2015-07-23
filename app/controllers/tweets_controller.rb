class TweetsController < ApplicationController
  def create
    current_user.twitter_client.update(params[:tweet])
    redirect_to root_path
  end
end
