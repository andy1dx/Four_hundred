class ArticlesController < ApplicationController
	before_action :authenticate_user!
	def list
		if current_user
		     @user_id = current_user.id
		else
		    redirect_to new_user_session_path, notice: 'You are not logged in.'
		end
	end

	def index
		@blog = Blog.joins(:user).where("users.status = 1 and (blogs.username = #{params["blog_id"]} or blogs.id = #{params["blog_id"]})").first
		if @blog != nil
			@articles = Article.where("blog_id = #{@blog.id} and articles.status != 0")
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

	def update
		@article = Article.find(params[:id])
		if(@article.update(article_params))
			@blog = Blog.joins(:user).where('users.status = 1 and blogs.id = "' + params["blog_id"] +'"').first
			redirect_to blog_articles_path(@article.blog_id)
        else
            render 'edit'
        end 
	end

	
	def edit
		@article = Article.find(params['id'])		
	end

    def destroy
		@article = Article.find(params[:id])
		if(@article.update(:status => 0))
			redirect_to blog_articles_path(@article.blog_id)
        else
			redirect_to blog_articles_path(@article.blog_id)
        end 
	end
	
	def show


	end

	private def article_params
		if params[:commit] == 'Save As Public'
			params.require(:article).permit(:title, :body).merge(status: 1)
		else
			params.require(:article).permit(:title, :body).merge(status: 2)
		end	
	end   
end
