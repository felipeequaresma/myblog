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
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  default_scope { order(created_at: :desc) }

  validates :text, :title, presence: true
end
