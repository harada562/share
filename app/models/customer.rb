class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :places, dependent: :destroy
  has_many :genres, dependent: :destroy
  has_many :groups_customers, dependent: :destroy

  # 3文字以上
  validates :nick_name,length: { minimum: 3 }

  # 一意性
  validates :nick_name, uniqueness: true

  # お問い合わせ
  has_many :inquiries, dependent: :destroy

  # いいね機能
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :place
  def already_liked?(place)
    self.likes.exists?(place_id: place.id)
  end

  # 画像アップロード機能
  attachment :image

  # 退会済みならログイン不可
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

# ゲストログイン用
  def self.guest
    find_or_create_by!(email: 'guest@gmail', nick_name: "ゲストアカウント") do |customer|
      customer.password = SecureRandom.urlsafe_base64
    end
  end
end
