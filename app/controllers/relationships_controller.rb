class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    follow = current_user.active_relationships.new(passive_follow_id: user.id)
    follow.save
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    follow = current_user.active_relationships.find_by(passive_follow_id: user.id)
    follow.destroy
    redirect_to request.referer
  end

  def active_follow
    @user = User.find(params[:user_id])
    @users = @user.active_follows
  end

  def passive_follow
    @user = User.find(params[:user_id])
    @users = @user.passive_follows
  end

end
