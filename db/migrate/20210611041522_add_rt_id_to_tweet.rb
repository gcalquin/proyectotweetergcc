class AddRtIdToTweet < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :retweeteado, :integer
  end
end
