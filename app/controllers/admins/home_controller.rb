class Admins::HomeController < ApplicationController
    before_action :authenticate_admin! #autothication for routing
    def index
        @users = User.joins("INNER JOIN blogs ON users.id = blogs.user_id").select("users.* , blogs.id as blog_id, blogs.url as blog_url, blogs.username as blog_username ")
    end

    def show
        @users = User.joins("INNER JOIN blogs ON users.id = blogs.user_id").select("users.* , blogs.id as blog_id, blogs.url as blog_url, blogs.username as blog_username").where("users.status =#{params[:id]}")
    end

    def blog
        @blog = Blog.find_by(id: params[:blog_id]) #getting article that not deleted
        @articles = Article.where("blog_id = #{params[:blog_id]} and articles.status != 0") #getting article that not deleted
    end

    def articledestroy
		@article = Article.find(params[:id])
		if(@article.update(:status => 0))
			redirect_to admin_blog_path(@article.blog_id)
        else
			redirect_to admin_blog_path(@article.blog_id)
        end 
    end    
    
    def article
        @article = Article.find(params["article_id"])
        @blog = Blog.joins(:user).where("users.status = 1 and (blogs.url = '#{params["blog_id"]}' or blogs.id = '#{params["blog_id"]}')").first
        @comments = Comment.joins("LEFT JOIN articles ON comments.article_id = articles.id LEFT JOIN blogs ON comments.user_id = blogs.user_id  LEFT JOIN users ON comments.user_id = users.id ").select("comments.*, blogs.username as username, users.avatar").where("articles.id = #{params["article_id"]}")

    end

    def commentdestroy

        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to admin_article_path(params[:blog_id], params[:article_id])
    end

    def inactivate
        @user = User.find(params[:id])
        if(@user.update(:status => 0))
            UsersMailer.inactive(@user).deliver
			redirect_to admin_home_path
        else
			redirect_to admin_home_path
        end 
    end

    def activate
        @user = User.find(params[:id])
        UsersMailer.active(@user).deliver
        if(@user.update(:status => 1))
			redirect_to admin_home_path
        else
			redirect_to admin_home_path
        end 
    end
end
