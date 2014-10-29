class Lesson < ActiveRecord::Base
  has_many :translations
  validates :title, presence:  true,
                    length: {minimum: 5}
end
