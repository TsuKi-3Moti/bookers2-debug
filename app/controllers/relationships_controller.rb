class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to request.referer
  end

  def active_follows
    user = User.find(params[:user_id])
    @users = user.active_follows
  end

  def passive_follows
    user = User.find(params[:user_id])
    @users = user.passive_follows
  end

end
