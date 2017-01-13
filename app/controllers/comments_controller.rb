class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.any { redirect_to @post.comment, notice: 'Comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post.comment }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title)
  end

end
