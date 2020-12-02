class HomeController < ApplicationController
  layout 'application'
  def index
    @posts = Post.all
  end
end
