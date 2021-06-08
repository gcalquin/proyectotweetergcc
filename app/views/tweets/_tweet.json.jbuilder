json.extract! tweet, :id, :contenido, :user_id, :created_at, :updated_at
json.url tweet_url(tweet, format: :json)
