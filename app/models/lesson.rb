class Lesson < ActiveRecord::Base
  has_many :translations, dependent: :destroy
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :title, presence:  true,
                    length: {minimum: 5}
  validates :user_id, presence: true
end
