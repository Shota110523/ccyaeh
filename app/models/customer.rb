class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.guest
    find_or_create_by!(email: 'guest@example.com', name: 'GUEST') do |customer|
      customer.password = SecureRandom.urlsafe_base64
    end
  end
end
