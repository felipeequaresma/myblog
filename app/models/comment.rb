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
class Comment < ApplicationRecord
  belongs_to :post

  default_scope { order(created_at: :desc) }

  validates :name, :comment, presence: true
end
