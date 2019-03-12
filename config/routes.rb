Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#index'
  resources :blog do
    resources :articles
    get '/:id' , to: 'articles#public', as: 'public_articles'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
