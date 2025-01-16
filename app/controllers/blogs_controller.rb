class BlogsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_blog, except: %i[index new create]

  def index
    @blogs = Blog.all
  end

  def show
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)

    if @blog.save
      redirect_to @blog
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog.destroy

    redirect_to root_path
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :body)
  end

  def find_blog
    @blog = Blog.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  # Devise gives us this already
  # def authenticate_user!
  #   redirect_to new_user_session_path, alert: "You need to sign in or sign up before continuing." unless user_signed_in?
  # end
end
