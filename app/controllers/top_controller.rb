class TopController < ApplicationController
  def index
    @posts = Post.order(created_at: "DESC").page(params[:page]).per(9)
  end
end
