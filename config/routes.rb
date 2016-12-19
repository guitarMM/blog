Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts
  root 'posts#index'
  get  "comments/new"
  get  "posts/save"
  get  "comments/save"

end
