class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :liking_users, :through => :likes, :source => :user

  paginates_per 4

  validates :contenido, presence:true

end
