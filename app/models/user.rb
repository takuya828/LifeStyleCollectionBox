class User < ApplicationRecord
  validates :handle_name, presence: true
  validates :email, presence: true
  validates :handle_name, uniqueness: true

  enum is_delete: { mukou: true, yuukou: false }

  def active_for_authentication?
    super && (is_delete === "yuukou")
  end

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post
  attachment :image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
