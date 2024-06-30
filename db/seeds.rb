User.destroy_all
Post.destroy_all
Comment.destroy_all

puts 'BANCO LIMPO COM SUCESSO!'

User.create!(
  [
    {
      email: 'user1@example.com',
      name: 'User 1',
      password: 'password123',
      password_confirmation: 'password123'
    },
    {
      email: 'user2@example.com',
      name: 'User 2',
      password: 'password123',
      password_confirmation: 'password123'
    }
  ]
)

Post.create!(
  [
    { title: 'Post 1', text: 'This is the first post', user: User.first },
    { title: 'Post 2', text: 'This is the second post', user: User.first },
    { title: 'Post 3', text: 'This is the third post', user: User.second },
    { title: 'Post 4', text: 'This is the fourth post', user: User.second }
  ]
)

Comment.create!(
  [
    { name: 'John Doe', comment: 'This is a great post!', post: Post.first },
    { name: 'Jane Doe', comment: 'I agree with John!', post: Post.first },
    { name: 'Bob Smith', comment: 'This post is okay...', post: Post.second },
    { name: 'Alice Johnson', comment: 'I love this post!', post: Post.second },
    { name: 'Mike Brown', comment: 'This post is amazing!', post: Post.second }
  ]
)

puts 'SEEDS CRIADAS COM SUCESSO!'
