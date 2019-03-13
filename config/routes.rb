Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#index'
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
