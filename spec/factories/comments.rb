# == Schema Information
#
# Table name: comments
#
#  id         :uuid             not null, primary key
#  name       :string
#  comment    :text
#  post_id    :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :comment do
    name { "User #{rand(1000)}" }
    comment { "testando #{rand(1000)}" }
    post
  end
end
