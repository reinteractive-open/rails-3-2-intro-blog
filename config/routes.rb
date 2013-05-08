QuickBlog::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => 'posts#index'

  resources :posts do
    resources :comments, :only => [:create]
  end
end
