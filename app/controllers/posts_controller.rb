class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
    @user = current_user
    @post = Post.where("user_id=?",@user.id).latest
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
    @post = Post.new
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def create
    @post = Post.new(params[:post])
    @user = current_user
    @post.user_id = @user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: '@post', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
    @user = current_user
  end

  def update
    @user = current_user
    @post = Post.find(params[:id])
    check = 'PARAM_OK'
    if @post.user_id == @user.id
      check = 'PARAM_OK'
    else
      check = 'PARAM_NG'
    end
    case check
      when 'PARAM_OK'
        respond_to do |format|
          if @post.update_attributes(params[:note])
            format.html { redirect_to @post, notice: 'Note was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @post.errors, status: :unprocessable_entity }
          end
        end
      when 'PARAM_NG'
        respond_to do |format|
          format.html { redirect_to notes_url , notice: 'You can not edit this item' }
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
            format.html { redirect_to post_path }
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
    params[:post].permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
