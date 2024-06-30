json.extract! @post, :id, :title, :text, :created_at

json.author do
  json.extract! @post.user, :id, :name
end

json.comments @post.comments do |comment|
  json.extract! comment, :name, :comment, :created_at
end
