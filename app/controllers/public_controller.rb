class PublicController < ApplicationController
    def index
        @blog = Blog.joins(:user).where('users.status = 1 and blogs.username = "' + params["blog_id"] +'"').first
        if @blog != nil
            @articles = Article.where("blog_id = #{@blog.id} and articles.status != 0")
        else
            redirect_to root
        end	
    end
end
