class PostsController < ApplicationController
  # before_action :logged_in_user, only: [:create, :destroy]
  # before_action :correct_user,   only: :destroy
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '記事を投稿しました！'
      redirect_to root_url
    else
      flash[:danger] = '記事の投稿に失敗しました'
      render 'posts/new'
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      flash[:success] = '記事を編集しました！'
      redirect_to action: :show, id: @post.id
    else
      flash[:danger] = '記事の編集に失敗しました'
      render "posts/#{@post.id}/edit"
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    flash[:success] = '記事を削除しました！'
    @post.destroy
    redirect_to root_url
  end

  private

  def post_params
    params.require(:post).permit(:ramen_name, :content, :image, :image_cache)
  end
end
