class ArticlesController < ApplicationController
	before_action :authenticate_user! #autothication for routing

	def list
		if current_user  # checking user
		     @user_id = current_user.id
		else
		    redirect_to new_user_session_path, notice: 'You are not logged in.' #redireting user checking
		end
	end

	def index
		@blog = Blog.joins(:user).where("users.status = 1 and (blogs.url = '#{params["blog_id"]}' or blogs.id = '#{params["blog_id"]}')").first #getting blog data by blog_id or blog_url
		if @blog != nil
			@articles = Article.where("blog_id = #{@blog.id} and articles.status != 0") #getting article that not deleted
		else
			redirect_to root
		end	
	end

	def new
		@article = Article.new
	end

	def create
		@blog = Blog.joins(:user).where("users.status = 1 and (blogs.url = '#{params["blog_id"]}' or blogs.id = '#{params["blog_id"]}')").first #getting data of active blog y url
		@article = Article.new(article_params) #making new article data from form
		@article.blog_id = @blog.id #adding blog id for saving
		if @article.save() #save data 
			redirect_to blog_index_path
		else
			render 'new' #if failed render new to disply errror
		end

	end

	def update
		@article = Article.find(params[:id]) #getting data that want to udate
		if(@article.update(article_params)) # checking updating data
			@blog = Blog.joins(:user).where('users.status = 1 and blogs.id = "' + params["blog_id"] +'"').first
			redirect_to blog_articles_path(@article.blog_id)
        else
            render 'edit' #if data is false open edit again
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
        @blog = Blog.joins(:user).where('users.status = 1 and blogs.url = "' + params["blog_id"] +'"').first
        @article = Article.where('articles.status <> 0 and articles.id = "' + params["id"] +'"').first
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
            redirect_to blog_index_path
        end
      
    end

	private def article_params
		if params[:commit] == 'Save As Public'
			params.require(:article).permit(:title, :body).merge(status: 1)
		else
			params.require(:article).permit(:title, :body).merge(status: 2)
		end	
	end   
end
