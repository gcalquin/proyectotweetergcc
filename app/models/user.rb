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


  def user_followed
    amigos = self.friends.pluck(:friend_id)
    User.find(amigos)
  end
  


  def is_following?(user)
      user_followed.include? (user)
  end
  

end
