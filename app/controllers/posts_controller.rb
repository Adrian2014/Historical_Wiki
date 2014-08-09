class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = Comment.where(post_id: params[:id])
    @tags = Post.find(params[:id]).tags
  end

  # GET /posts/new
  def new
    @post = Post.new
    @tag = Tag.new
  end

  # GET /posts/1/edit
  def edit
    @tag = Tag.new
    @tags = Tag.where(post_id: params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.tags << Tag.new(tag_params)
    @post.user_id = session[:id]

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

    tag = Tag.new(tag_params)
    respond_to do |format|
      if @post.update(post_params) && tag.save
        @post.tags << tag
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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:post_title, :post_text, :post_date)
  end
  def tag_params
    params.require(:tag).permit(:tag_text)
  end
end
