class ArticlesController < ApplicationController
	def list
		if current_user
		     @user_id = current_user.id
		else
		    redirect_to new_user_session_path, notice: 'You are not logged in.'
		end
	end

	def index
		@blog = Blog.joins(:user).where('users.status = 1 and blogs.username = "' + params["blog_id"] +'"').first
		if @blog != nil
			@articles = Article.where("blog_id = #{@blog.id}")
		else
			redirect_to root
		end	
	end

	def new
		@article = Article.new
	end

	def create
		@blog = Blog.joins(:user).where('users.status = 1 and blogs.username = "' + params["blog_id"] +'"').first
		@article = Article.new(article_params)
		@article.blog_id = @blog.id
		if @article.save()
			redirect_to blog_index_path
		else
			render 'new'
		end

	end

	private def article_params
        params.require(:article).permit(:title, :body)
    end   
end
