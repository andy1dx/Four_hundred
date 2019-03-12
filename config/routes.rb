Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#index'
  resources :blog do
    resources :articles do
      resources :comments
    end
  end
  get '/public/:blog_id' , to: 'public#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
