Rails.application.routes.draw do
  # letterOpenerWeb
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "posts#index"

  resources :users, only: %i[index new create edit update]
  resources :password_resets, only: %i[new create edit update]
  resource :profile, only: %i[show edit update] do
    collection do
      get 'questions', to:'profiles#questions'
      get 'tweets', to:'profiles#tweets'
      get 'comments', to:'profiles#comments'
      get 'favorite_posts', to:'profiles#favorite_posts'
      get 'favorite_comments', to:'profiles#favorite_comments'
    end
  end

  resources :post_notifications, only: %i[index] do
    patch :checked, on: :member
    delete :checked_all, on: :collection
  end

  resources :comment_notifications do
    patch :checked, on: :member
  end

  resource :care_persons, only: %i[new create show edit update]
  resources :posts do
    resources :comments do
      get :comment_favorites
    end
    collection do
      get 'search', to:'posts#search'
      get  'autocomplete_word', to:'posts#autocomplete_word'
    end
  end

  resources :post_favorites, only: %i[create destroy]
  resources :comment_favorites, only: %i[create destroy]

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  
end
