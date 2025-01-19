class CommentsController < ApplicationController
  before_action :set_blog_post

  def create
    @comment = @blog_post.comments.new(comment_params)
    @comment.user = current_user # If you are using Devise for authentication

    if @comment.save
      redirect_to @blog_post, alert: "Comment was successfully created."
    else
      redirect_to @blog_post, alert: "Error creating comment."
    end
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:blog_post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
