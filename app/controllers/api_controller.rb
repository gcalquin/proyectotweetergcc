class ApiController < ApplicationController

skip_before_action :verify_authenticity_token

  def news
    ## Esta api solo muestra los ultimos 5 Tweets
    ## render json: Tweet.last(5)

    tweets = Tweet.last(5)

    api = tweets.map do |t|
      {
        :id => t.id,
        :content => t.contenido,
        :user_id => t.user_id,
        :like_count => t.likes.count,
        :retweets_count => t.count_rt,
        :retweeted_from => t.retweeteado,
        :creado => t.created_at
      }
    end

    render json: api

  end

  def fechas
    fecha1 = Date.parse(params[:fecha1])
    fecha2 = Date.parse(params[:fecha2])
    
    tweets = Tweet.where(created_at: fecha1..fecha2)
    render json: tweets

  end
  
def crear_tweet_api
  user = User.authenticate(params[:email], params[:password])
  if !user.nil?
  @tweet = Tweet.new(tweet_params)
  @tweet.user = user
  if @tweet.save
    render json: @tweet
  else
    render json: { errors: "error"}
  end
else 
  render json: { errors: "error de autentificacion..."}
end 
end

private
def tweet_params
   params.require(:tweet).permit(:contenido, :user_id)
end



end
