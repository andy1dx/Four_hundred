class CommentController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        if @comment.save
            @blog = Blog.find(params["blog_id"])
            session['commentSuccess'] = true
            redirect_to public_article_path(@blog.url, @comment.article_id)
        else
            abort  @comment.inspect
            @blog = Blog.find(params["blog_id"])
            session['commentSuccess'] = false
            redirect_to public_article_path(@blog.url, @comment.article_id)
        end
    end

    private def comment_params
        params.require(:comment).permit(:body, :user_id ,:article_id)
    end   
end
