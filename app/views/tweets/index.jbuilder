json.tweets do
  json.array! @tweets do |tweet|
    json.id         tweet.id
    json.message    tweet.message
    json.completed  tweet.completed
    json.created_at tweet.created_at
  end
end
