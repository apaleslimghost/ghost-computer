class TagsController < ApplicationController
  def show
    @tag = Tag.find_by_name!(params[:id])
    @posts = @tag.posts

    render 'posts/index'
  end
end
