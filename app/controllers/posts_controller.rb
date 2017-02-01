class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.page(params[:page]).per(10).order(created_at: :desc)
    @user = current_user

    if params[:sort] == 'old'
      @posts = Post.page(params[:page]).per(10).order(created_at: :asc)
    else
    end

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = current_user
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      redirect_to root_path, notice: 'Post was successfully created.'
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
        if @post.update post_params
          redirect_to post_path(@post.id), notice: 'Note was successfully updated.'
        else
          render action: 'edit'
        end
      end
    else
      redirect_to post_path(@post.id), notice: 'You can not edit this item'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @user = current_user
    if @post.user_id == @user.id
      @post.destroy
      redirect_to root_path
    else
      redirect_to post_path, notice: 'You can not delete this item'
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
