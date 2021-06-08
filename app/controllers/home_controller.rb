class HomeController < ApplicationController
  def index
   ## @tweets = Tweet.all -- Muestra todos los Tweets
   @tweets = Tweet.page params[:page]
  end
end
