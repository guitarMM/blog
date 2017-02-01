class CommentsController < ApplicationController

    def create
        @post = Post.find params[:post_id]
        @comment = @post.comments.new comment_params
        @comment.user = current_user
        if @comment.save
            redirect_to @comment.post, notice: 'Comment was successfully created.'
        else
            @comment.user = current_user
            render template: 'posts/show'
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:title)
    end
end
