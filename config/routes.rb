Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root :to => 'homes#top'
  get "home/about"=>"homes#about"
  get "search" => "searches#search"
  get "search_tag" => "books#search_tag"

  resources :relationships,       only: [:create, :destroy]
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
      #単数形にすると、/:idがURLに含まれなくなる。
      #コメント機能とは異なり、いいね機能の場合は「1人のユーザーは1つの投稿に対して1回しかいいねできない」という仕様であるため、
      #ユーザーidと投稿idが分かれば、どのいいねを削除すればいいのかが特定できdestroyできる。
      #そのため、いいねのidはURLに含める必要がない(params[:id]を使わなくても良い)ため、
      #resourcesではなくresourceを使ってURLに/:idを含めない形にする。
  end

  resources :users, only: [:index,:show,:edit,:update] do
        member do
      get :following, :followers
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
