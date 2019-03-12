class BlogController < ApplicationController
    def index
        if user_signed_in? 
            @check = Blog.find_by(user_id: current_user.id)
            if @check != nil
                @blog = @check
                @articles = Article.where("blog_id = #{@blog.id}").order(:created_at).limit(10)
            else
                @blog = Blog.new
            end
        else
            redirect_to root_path
        end
    end

    def create
        #render plain: params[:post].inspect
        @blog = Blog.find_by(user_id: current_user.id)
        if @blog != nil
            if(@blog.update(blog_params))
                @success = true;
                render 'index'
            else
                @success = false;
                render 'index'
            end    
        else
            @blog = Blog.new(blog_params)
            @blog.user_id = current_user.id
            if(@blog.save())
                @success = true;
                render 'index'
            else
                @success = false;
                render 'index'
            end    
        end
    end


    
    private def blog_params
        params.require(:blog).permit(:title, :description, :url, :username)
    end    

    def show
		@blog = Blog.joins(:user).where('users.status = 1 and blogs.username = "' + params["id"] +'"').first
        if @blog != nil
			@articles = Article.where("blog_id = #{@blog.id} and articles.status != 0")
		else
			redirect_to root
		end	
    end
end
