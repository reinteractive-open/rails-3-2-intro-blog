QuickBlog::Application.routes.draw do
  resources :posts do
    resources :comments, :only => [:create]
  end

  # root :to => 'welcome#index'
end


