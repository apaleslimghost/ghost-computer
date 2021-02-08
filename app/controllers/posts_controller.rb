class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy like]
  before_action :check_access, only: %i[new create edit update destroy upload]

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

  def upload
    uploaded = params[:files].flat_map do |file|
      content_type = Marcel::MimeType.for file, name: file.original_filename, declared_type: file.content_type
      case content_type
      when %r{text/(markdown|plain)}
        post = Post.from_markdown(file.read)
        post.author = current_user
        post.save!
        post
      else
        ActiveStorage::Blob.create_and_upload!(
          io: file,
          filename: file.original_filename
        )
      end
    end

    render json: uploaded
  end

  def asset
    redirect_to ActiveStorage::Blob.find_by_filename!(params[:path])
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.tags = Tag.tags_from_string(params[:tags])
    @post.author = current_user
    puts @post.tags.map(&:name)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    @post.tags = Tag.tags_from_string(params[:tags])
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def like
    @post.increment!(:likes)
    render js: 'Turbolinks.visit(location)'
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
