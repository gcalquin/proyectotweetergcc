class HomeController < ApplicationController
  def index
   ## @tweets = Tweet.all -- Muestra todos los Tweets
   @tweets = Tweet.order(created_at: :desc).page params[:page]
   @tweet = Tweet.new
  end
end
