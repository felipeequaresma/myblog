json.array! @comments do |comment|
  json.extract! comment, :name, :comment, :created_at
end
