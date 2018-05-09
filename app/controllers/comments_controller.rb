# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    redirect_to post_path(@post) if @comment.save
  end

  def destroy
    @post = Post.find(params[:id])
    @comment = @post.comments.find(params[:post_id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
