class HomeController < ApplicationController
  def index
    @blogs = Blog.joins("LEFT JOIN articles ON blogs.id = articles.blog_id LEFT JOIN users ON blogs.user_id = users.id ").group(:id).select("blogs.*, count(articles.id) as articles_count").where("articles.status = 1 and users.status <> 0")
    
  end
end
