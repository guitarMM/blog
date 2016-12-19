class CommentsController < ApplicationController

  def new
    @comment = Post.comment.new
  end

  def create
    @post = Post.find (params[:post_id])
    @comment = @post.comments.new(comment_params)
    respond_to do |format|
      if Post.comment.save
        format.any { redirect_to @comment.post, notice: 'Comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comment.post }
      else
        format.html { render template: 'posts/show' }
        format.json { render json: @comment.post.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title)
  end

end
