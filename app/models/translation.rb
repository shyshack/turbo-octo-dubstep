class Translation < ActiveRecord::Base
  belongs_to :lesson
  validates :first_language, presence: true
  validates :second_language, presence: true
end
