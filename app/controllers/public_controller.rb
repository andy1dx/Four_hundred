class PublicController < ApplicationController
    def index
        @blog = Blog.joins(:user).where('users.status = 1 and blogs.url = "' + params["blog_id"] +'"').first
        if @blog != nil
            @articles = Article.where("blog_id = #{@blog.id} and articles.status != 0")
            if  @articles.empty?
                redirect_to root_path
            end
        else
            redirect_to root_path
        end	
    end

    def show
        @blog = Blog.joins(:user).where('users.status = 1 and blogs.url = "' + params["blog_id"] +'"').first
        @article = Article.where('articles.status = 1 and articles.id = "' + params["id"] +'"').first
        @count   = Like.where(:article_id => @article.id).count
        if @article != nil
            @comments = Comment.joins("LEFT JOIN articles ON comments.article_id = articles.id LEFT JOIN blogs ON comments.user_id = blogs.user_id  LEFT JOIN users ON comments.user_id = users.id ").select("comments.*, blogs.username as username, users.avatar").where("articles.id = #{params["id"]}")
            @comment = Comment.new
            if user_signed_in?
                @comment.user_id = current_user.id
                @comment.article_id = @article.id
                @like = Like.find_by(:article_id => @article.id , :user_id => current_user.id)
               
            end        
        else
            redirect_to root_path
        end
    end
end
