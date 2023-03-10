class FollowsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @follow = @user.follows.find_by(user: current_user)
    unless @follow
      @follow = Follow.new
    end
  end

  def create
    # has_many :follows_as_follower
    # has_many :follows_as_following
    # t.bigint "follower_id", null: false
    # t.bigint "following_id", null: false
    @following = User.find(params[:user_id])
    @follow = Follow.new(
      follower: current_user,
      following: @following
    )
    @follow.save
    if @follow.save
      flash[:success] = "You are now following user ##{@following.user_name}!"
      redirect_to user_path(@following)
    else
      flash.now[:error] = "There was an error following user ##{@following.user_name}. Please try again."
      render :new
    end
  end


  def destroy
    @follow = Follow.find(params[:id])
    @following = @follow.following
    @follow.destroy
    if @follow.destroy
      flash[:success] = "You have unfollowed user ##{@following.user_name}."
      redirect_to user_path(@following)
    else
      flash[:error] = "There was an error unfollowing user
      #{@following.user_name}. Please try again."
      render "user/show", status: :unprocessable_entity
    end
  end
end
