class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy like]
  before_action :check_access, only: %i[new create edit update destroy]

  # GET /posts
  def index
    @posts = Post.order(posted: :desc)
  end

  # GET /posts/1
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def like
    @post.increment!(:likes)
    redirect_to @post
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def check_access
    raise ActionController::RoutingError, 'Not Found' unless current_user && (!@post || @post.author == current_user)
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :posted, :body)
  end
end
