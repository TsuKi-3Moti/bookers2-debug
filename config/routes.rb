Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get "/home/about" => "homes#about"

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get "/relationship/:user_id/active_follows" =>
          "relationships#active_follow", as: "user_active_follows"
    get "/relationship/:user_id/passive_follows" =>
          "relationships#passive_follow", as: "user_passive_follows"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
