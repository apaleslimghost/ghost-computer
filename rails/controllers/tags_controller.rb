class TagsController < ApplicationController
  def show
    @tag = Tag.find_by_name!(params[:id])
    @posts = @tag.posts.order(posted: :desc)

    respond_to do |format|
      format.html { render 'posts/index' }
      format.rss { render 'posts/index', layout: false }
    end
  end
end
