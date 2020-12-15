class TagsController < ApplicationController
  def show
    @tag = Tag.find_by_name!(params[:id])
    @posts = @tag.posts.order(posted: :desc)

    render 'posts/index'
  end
end
