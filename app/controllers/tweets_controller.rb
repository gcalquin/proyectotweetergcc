class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy ]

 before_action :set_current_tweet, only: %i[ likes retweet]


  # GET /tweets or /tweets.json
  def index
    @tweets = Tweet.all
  end

  # GET /tweets/1 or /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  def likes
      if @tweet.is_liked?(current_user)
       @tweet.remove_like(current_user)
    else
        @tweet.add_like(current_user)
    end
    redirect_to root_path
  end

  def retweet
    new_tweet = Tweet.create(contenido: @tweet.contenido, user: current_user, retweeteado: @tweet.id)
    redirect_to root_path
  end
  

    
  

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params.merge(user: current_user))

    respond_to do |format|
      if @tweet.save
     ## original   format.html { redirect_to @tweet, notice: "Tweet was successfully created." }
        format.html { redirect_to root_path, notice: "Tweet creado exitosamente." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:contenido, :user_id)
    end

    def set_current_tweet
      @tweet = Tweet.find(params[:tweet_id])
    end
    

end
