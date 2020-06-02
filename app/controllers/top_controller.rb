class TopController < ApplicationController
  def index
    @search = Post.search(params[:q])
    @posts = @search.result.order(created_at: 'DESC').page(params[:page]).per(9)
  end
end
