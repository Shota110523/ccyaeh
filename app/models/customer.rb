class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :post

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
    end
  end
end
