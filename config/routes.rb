PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get 'register', to: 'users#new'
  get '/profile/edit', to: 'users#edit'
  get '/profile', to: 'users#show'


  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :posts, except: :destroy do
  	resources :comments, only: :create do
      member do
        post :vote # post/3/comment/4/votes
      end

      # collection do
      #   get :whoa # post/3/comment/whoa
      # end
    end

    member do
      post :vote # post/3/votes
    end
  end

  resources :categories, except: :destroy

  resources :users, only: [:create, :update]
end
