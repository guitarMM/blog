class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
    @user = current_user
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = current_user
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def new
    @post = Post.new
    @user = current_user
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def create
    @post = Post.new (post_params)
    @post.user = current_user
    if @post.save
      redirect_to root_path , notice: 'Post was successfully created.'
    else
      @user = current_user
      render action: :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @user = current_user
    @post.user_id = @user.id
  end

  def update
    @user = current_user
    @post = Post.find(params[:id])
    if @post.user_id == @user.id
      respond_to do |format|
        if @post.update (post_params)
          format.html { redirect_to post_path(@post.id), notice: 'Note was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to post_path(@post.id) , notice: 'You can not edit this item' }
        format.json { head :no_content }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @user = current_user
    check = 'PARAM_OK'
    if @post.user_id == @user.id
      check = 'PARAM_OK'
    else
      check = 'PARAM_NG'
    end
    case check
      when 'PARAM_OK'
        respond_to do |format|
            @post.destroy
            format.html { redirect_to root_path }
            format.json { head :no_content }
        end
      when 'PARAM_NG'
        respond_to do |format|
            format.html { redirect_to post_path , notice: 'You can not delete this item' }
            format.json { head :no_content }
        end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
