class RelationshipsController < ApplicationController
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  
  def follows
    user = User.find(params[:user_id])
    @follows = user.following_users
  end
  
  def followers
    user = User.find(params[:user_id])
    @followers = user.followed_users
  end
end
