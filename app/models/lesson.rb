class Lesson < ActiveRecord::Base
  has_many :translations, dependent: :destroy
  validates :title, presence:  true,
                    length: {minimum: 5}
end
