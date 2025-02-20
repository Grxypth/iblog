class BlogPostsController < ApplicationController
  before_action :set_blog_post, except: %i[create new index]
  before_action :authenticate_user!, except: %i[index show]
  before_action :authorize_user!, only: %i[edit update destroy]

  def index
    if params[:search].present?
      @blog_posts =
        BlogPost.where(
          "title LIKE ? OR body LIKE ?",
          "%#{params[:search]}%",
          "%#{params[:search]}%"
        )
    else
      @blog_posts = BlogPost.all
    end
  end

  def show
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = current_user.blog_posts.new(blog_post_params) # Associate with current_user
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to root_path
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body, :image) # Permit the image parameter
  end

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, status: :not_found
  end

  def authorize_user!
    unless @blog_post.user == current_user
      redirect_to blog_posts_path,
                  alert: "You are not authorized to perform this action."
    end
  end
end
