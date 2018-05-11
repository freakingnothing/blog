# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :admin_user, except: %i[index show]

  def index
    @posts = Post.published.order('published_at DESC').page(params[:page]).per(10)
  end

  def draft_posts
    @posts = Post.draft.order('updated_at DESC').page(params[:page]).per(10)
  end

  def show
    @post = Post.friendly.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.publish if publishing?
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.publish if publishing?
    @post.unpublish if unpublishing?
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post_status = @post.status
    @post.destroy
    @post_status == 'published' ? (redirect_to root_path) : (redirect_to draft_path)
  end

  private

  def post_params
    params.require(:post).permit(:state_event, :title, :body, tag_ids: [])
  end

  def publishing?
    params[:commit] == 'Publish'
  end

  def unpublishing?
    params[:commit] == 'Un-publish'
  end
end
