Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/blog_posts/new" => "blog_posts#new", :as => :new_blog_post
  get "/blog_posts/:id" => "blog_posts#show", :as => :blog_post
  patch "/blog_posts/:id", to: "blog_posts#update"
  get "/blog_posts/:id/edit", to: "blog_posts#edit", as: :edit_blog_post
  post "/blog_posts" => "blog_posts#create", :as => :blog_posts

  # Defines the root path route ("/")
  root "blog_posts#index"
end
