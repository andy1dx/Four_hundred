class BlogController < ApplicationController

    before_action :authenticate_user!
    def index
        if session["imageSuccess"] != nil
            if session["imageSuccess"] == true
                @successImage = true
                session["imageSuccess"] = nil
            else
                @successImage = session["imageSuccess"] 
                session["imageSuccess"] = nil
            end                
        end
 
        if user_signed_in? 
            @userImage = User.find(current_user.id)

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

    def avatar
        @user = User.find(current_user.id)

        if @user.update(avatar_params)
            session["imageSuccess"] = true
            redirect_to blog_index_path
        else
            if @user.errors.messages[:avatar][0] != nil
                session["imageSuccess"] = @user.errors.messages[:avatar][0]
            else
                session["imageSuccess"] = "UPLOAD FAILED"
            end    
            redirect_to blog_index_path
        end
    end
    
    private def blog_params
        params.require(:blog).permit(:title, :description, :url, :username)
    end    

    private def avatar_params
        params.require(:user).permit(:avatar)
    end    

    def show
		@blog = Blog.joins(:user).where('users.status = 1 and blogs.url = "' + params["id"] +'"').first
        if @blog != nil
			@articles = Article.where("blog_id = #{@blog.id} and articles.status != 0")
		else
			redirect_to root
		end	
    end
end
