class HomeController < ApplicationController
  def index
    @posts = Post.order(posted: :desc)
  end
end
