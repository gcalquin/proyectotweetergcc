Rails.application.routes.draw do
  get 'api/news'

  get "/:fecha1/:fecha2", to: "api#fechas", as: "fechas"

  post "/tweets", to: "api#crear_tweet_api"

  ActiveAdmin.routes(self)
  #get 'users/follow'
  resources :tweets do
    post "likes", to: "tweets#likes"
    post "retweet", to: "tweets#retweet"
  end




  devise_for :users
  get 'home/index'

  get "all_tweets" , to: "home#all_tweets", as: "all_tweets"



  post 'follow/:user_id', to: "users#follow", as: "users_follow"

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
