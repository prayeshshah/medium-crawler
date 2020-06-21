class BlogsController < ApplicationController

  def create
    Blog.crawl_and_create(params[:tag])
    redirect_to root_path
  end

  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find_by_id params[:id]
  end

end