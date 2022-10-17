class Post < ApplicationRecord
   has_one_attached :image
   belongs_to :customer
   has_many :comments, dependent: :destroy

   validates :image, presence: true

end
