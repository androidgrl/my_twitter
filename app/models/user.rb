class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    require 'byebug'; byebug
    if user = find_by(uid: auth_info.uid)
      user
    else
      create({name: auth_info.extra.raw_info.name,
              screen_name: auth_info.extra.raw_info.screen_name,
              uid: auth_info.uid,
              oauth_token: auth_info.credentials.token,
              oauth_token_secret: auth_info.credentials.secret,
              profile_url: auth_info.extra.raw_info.profile_image_url,
              background_url: auth_info.extra.raw_info.profile_banner_url,
              followers_count: auth_info.extra.raw_info.followers_count,
              friends_count: auth_info.extra.raw_info.friends_count,
              tweet_count: auth_info.extra.raw_info.statuses_count})
    end
  end

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["CONSUMER_KEY"]
      config.consumer_secret = ENV["CONSUMER_SECRET"]
      config.access_token = oauth_token
      config.access_token_secret = oauth_token_secret
    end
  end

  def twitter_timeline
    twitter_client.home_timeline
  end
end
