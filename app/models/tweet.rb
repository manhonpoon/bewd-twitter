class Tweet < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  validates :message, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
end
