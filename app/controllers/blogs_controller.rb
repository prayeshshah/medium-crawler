class BlogController < ApplicationController

  def create
    Blog.crawl_and_create(params[:tag])
    render nothing: true
  end
end