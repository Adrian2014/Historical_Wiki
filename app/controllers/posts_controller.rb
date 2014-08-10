class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.sort_by(&:updated_at).last(5).reverse
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = Comment.where(post_id: params[:id])
    @tags = Post.find(params[:id]).tags
    @image = Post.find(params[:id]).image
  end

  # GET /posts/new
  def new
    @post = Post.new
    @tags = []
    @tag = Tag.new
    @image = Image.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @tags = @post.tags
    @tag = Tag.new
    if @post.image == nil 
      @image = Image.new
    else 
      @image = @post.image
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    @post.tags = []

    params["tag"]["tag_text"].split(",").map(&:strip).each do |tag_text|
      new_tag = Tag.find_by(tag_slug: tag_text.parameterize) || Tag.create(tag_text: tag_text)
      new_tag.posts.push @post unless new_tag.posts.find_by(id: @post.id)
    end

    @post.user_id = session[:id]

    @post.image = Image.create(image_url: params["image"]["image_url"])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update

    @post.tags = []

    params["tag"]["tag_text"].split(",").map(&:strip).each do |tag_text|
      puts tag_text
      new_tag = Tag.find_or_create_by(tag_text: tag_text, tag_slug: tag_text.parameterize)
      new_tag.posts.push @post unless new_tag.posts.find_by(id: @post.id)
    end

    @post.image = Image.find_or_create_by(post_id: @post.id, image_url: params["image"]["image_url"])

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # returns a json object containing Post objects:
  # For each comment, return the id, title, and date
  def get_data
    @posts = Post.all.order(:post_date)
    @first_year = (params['start_year'] || 1900).to_i
    @last_year  = (params['end_year'] || 2000).to_i
    @precision  = (params['precision'] || 10).to_i

    render 'data.json.jbuilder'
  end

  # Returns all the posts on a certain year
  def posts_by_year
    @year = params[:year].to_i
    puts @year
    @posts = Post.all.select{ |post| post.year == @year }
    puts @posts

    render 'year'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:post_title, :post_text, :post_date)
  end
end
