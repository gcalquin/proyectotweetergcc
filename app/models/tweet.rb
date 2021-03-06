class Tweet < ApplicationRecord
 include ActionView::Helpers::UrlHelper

  before_save :hashtag
  belongs_to :user
  has_many :likes
  has_many :liking_users, :through => :likes, :source => :user

  paginates_per 4

  scope :tweets_for_me, -> (user) {where(user_id: User.find(user.id).friends.pluck(:friend_id))}



  def is_liked?(user)
    if self.liking_users.include?(user)
      true
    else
      false
    end
  end

  


  def remove_like(user)
    Like.where(user: user, tweet: self).first.destroy
  end

  def add_like(user)
    Like.create(user: user, tweet: self)    
  end



  def hashtag
    arreglo = []
    self.contenido.split(" ").each do |p|
      if p.start_with?("#")
        p_parsed = p.sub "#", "%23"
        p = link_to( p, Rails.application.routes.url_helpers.root_path+"?search="+p_parsed )
      end
      arreglo.push(p)
    end
    self.contenido = arreglo.join(" ")
  end

  
  def count_rt
    Tweet.where(retweeteado: self.id).count
  end

  def is_retweet?
    retweeteado ? true : false
  end

  def tweet_ref
    Tweet.find(self.retweeteado)
  end
  

  
  

  validates :contenido, presence:true

end
