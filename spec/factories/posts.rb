# == Schema Information
#
# Table name: posts
#
#  id         :uuid             not null, primary key
#  title      :string
#  text       :text
#  user_id    :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :post do
    
  end
end
