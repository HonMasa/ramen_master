class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    unless current_user.already_liked?(@post)
      @post.like(current_user)
      @post.reload
      respond_to do |format|
        format.html { redirect_to request.referer || root_url }
        format.js
      end
    end
    return if current_user.already_liked?(@post)
  end

  def destroy
    @post = Like.find(params[:id]).post
    if current_user.already_liked?(@post)
      @post.dislike(current_user)
      @post.reload
      respond_to do |format|
        format.html { redirect_to request.referer || root_url }
        format.js
      end
    end
    return unless current_user.already_liked?(@post)
  end
end
