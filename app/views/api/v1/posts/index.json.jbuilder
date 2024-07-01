json.array! @posts do |post|
  json.extract! post, :id, :title, :text, :created_at
  json.author do
    json.extract! post.user, :id, :name
  end
end
