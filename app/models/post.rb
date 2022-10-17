class Post < ApplicationRecord
   has_one_attached :image
   belongs_to :customer

   validates :image, presence: true

end
