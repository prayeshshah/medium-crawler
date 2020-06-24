class BlogsController < ApplicationController

  def create
    tags = params[:tag].split(/[\s,]+/) if params[:tag]
    tags.reject!{ |t| Blog.where(search_tag: t).present? } # only crawl tags which have not been crawled before
    Blog.crawl_and_create(tags) if tags.present?
    redirect_to controller: 'blogs', action: 'index', tag: params[:tag]
  end

  def index
    tags = params[:tag].split(/[\s,]+/) if params[:tag]
    @blogs = tags.present? ? Blog.where(search_tag: tags) : Blog.all
    @blog_count = @blogs.count
  end

  def show
    @blog = Blog.find_by_id params[:id]
  end

end