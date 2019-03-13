class PublicController < ApplicationController
    def index
        @blog = Blog.joins(:user).where('users.status = 1 and blogs.url = "' + params["blog_id"] +'"').first
        if @blog != nil
            @articles = Article.where("blog_id = #{@blog.id} and articles.status != 0")
        else
            redirect_to root
        end	
    end

    def show
        @blog = Blog.joins(:user).where('users.status = 1 and blogs.url = "' + params["blog_id"] +'"').first
        @article = Article.where('articles.status = 1 and articles.id = "' + params["id"] +'"').first
        @comments = Comment.joins("LEFT JOIN articles ON comments.article_id = articles.id LEFT JOIN blogs ON comments.user_id = blogs.user_id ").select("comments.*, blogs.username as username").where("articles.id = #{params["id"]}")
        @comment = Comment.new
        if user_signed_in?
            @comment.user_id = current_user.id
            @comment.article_id = @article.id

        end        
    end
end
