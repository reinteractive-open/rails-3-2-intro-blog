QuickBlog::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => 'posts#index'

  resources :posts do
    resources :comments, :only => [:create]
  end

  get '/about', :to => 'pages#about'

  match '/404', :to => 'errors#not_found'
  match '/500', :to => 'errors#internal_error'
  match '/422', :to => 'errors#unprocessable_entity'
end
