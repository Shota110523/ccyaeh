class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # フォローしたときの処理
  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end
  # フォローを外すときの処理
  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
  end
  # フォローしているか判定
  def following?(customer)
    followings.include?(customer)
  end
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @Customer = Customer.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @Customer = Customer.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @Customer = Customer.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @Customer = Customer.where("name LIKE?","%#{word}%")
    else
      @Customer = Customer.all
    end
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com', name: 'GUEST') do |customer|
      customer.password = SecureRandom.urlsafe_base64
    end
  end
end
