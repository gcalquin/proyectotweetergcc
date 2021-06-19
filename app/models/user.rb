class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friends         

  has_many :tweets

  has_many :likes

  has_many :liked_tweet, :through => :likes, :source => :tweet

  ##def arr_friends_id
  ##  arr_ids = self.friends.pluck(:friend_id)
  ##  User.find(arr_ids)
  ##end

  #def admin
  #  self.admin ? true : false
  #end
  


  def user_followed
    amigos = self.friends.pluck(:friend_id)
    User.find(amigos)
  end
  


  def is_following?(user)
      user_followed.include? (user)
  end

  def Cuentas_que_sigue
    self.friends.count
  end

  def Tweets_realizados
    self.tweets.count
  end

  def Likes_dados
    self.likes.count
  end

  def Candidad_de_retweets
    self.tweets.where.not(retweeteado: nil).count
  end
  
  
  
  

end
