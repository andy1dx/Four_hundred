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

    def index
        @article = Article.find(params["article_id"])
        @blog = Blog.joins(:user).where("users.status = 1 and (blogs.url = '#{params["blog_id"]}' or blogs.id = '#{params["blog_id"]}')").first
        @comments = Comment.joins("LEFT JOIN articles ON comments.article_id = articles.id LEFT JOIN blogs ON comments.user_id = blogs.user_id  LEFT JOIN users ON comments.user_id = users.id ").select("comments.*, blogs.username as username, users.avatar").where("articles.id = #{params["article_id"]}")
    end

    def destroy

        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to blog_article_comment_index_path(params[:blog_id], params[:article_id])
    end
    private def comment_params
        params.require(:comment).permit(:body, :user_id ,:article_id)
    end   
end
