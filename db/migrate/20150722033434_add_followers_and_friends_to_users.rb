class AddFollowersAndFriendsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :followers_count, :integer
    add_column :users, :friends_count, :integer
  end
end
