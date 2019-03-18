Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#index'
  get '/admins' , to: 'admins/home#index', as: 'admin_home'
  get '/admins/:id' , to: 'admins/home#show', as: 'admin_status'
  post '/admins/activate/:id' , to: 'admins/home#activate', as: 'admin_activate'
  post '/admins/inactivate/:id' , to: 'admins/home#inactivate', as: 'admin_inactivate'
  get '/admins/blog/:blog_id' , to: 'admins/home#blog', as: 'admin_blog'
  delete '/admins/blog/:blog_id/:id' , to: 'admins/home#articledestroy', as: 'admin_destroy_article'
  get '/admins/:blog_id/article/:article_id' , to: 'admins/home#article', as: 'admin_article'
  delete '/admins/:blog_id/article/:article_id/:id' , to: 'admins/home#commentdestroy', as: 'admin_destroy_comment'
  # get '/admins/:blog_id/article/:article_id' , to: 'admins/home#comment', as: 'admin_comment'
  devise_for :admins , controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }
  resources :blog do
    resources :articles do
      resources :comment
      resources :like
    end
  end
  post 'avatar', to: 'blog#avatar', as: 'save_avatar'
  get '/public/:blog_id' , to: 'public#index', as: 'public_blog'
  get '/public/:blog_id/:id' , to: 'public#show', as: 'public_article'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
