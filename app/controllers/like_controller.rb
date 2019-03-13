class LikeController < ApplicationController
    def create
        @like = Like.create(user_id: current_user.id, article_id: params[:article_id])
        redirect_to public_article_path(params[:blog_id], params[:article_id])
    end

    def destroy
        @Like = Like.find(params[:id])
        @Like.destroy
        redirect_to public_article_path(params[:blog_id], params[:article_id])
    end
end
