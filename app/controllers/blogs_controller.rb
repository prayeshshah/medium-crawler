class BlogsController < ApplicationController

  def create
    tags = params[:tag].split(',').map(&:strip) if params[:tag]
    Blog.crawl_and_create(tags) #unless Blog.find_by_search_tag(params[:tag]).present?
    redirect_to controller: 'blogs', action: 'index', tag: params[:tag]
  end

  def index
    tags = params[:tag].split(',').map(&:strip) if params[:tag]
    @blogs = tags.present? ? Blog.where(search_tag: tags) : Blog.all
  end

  def show
    @blog = Blog.find_by_id params[:id]
  end

end