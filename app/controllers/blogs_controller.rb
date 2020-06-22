class BlogsController < ApplicationController

  def create
    Blog.crawl_and_create(params[:tag]) unless Blog.find_by_search_tag(params[:tag]).present?
    redirect_to controller: 'blogs', action: 'index', tag: params[:tag]
  end

  def index
    @blogs = params[:tag].present? ? Blog.where(search_tag: params[:tag]) : Blog.all
  end

  def show
    @blog = Blog.find_by_id params[:id]
  end

end