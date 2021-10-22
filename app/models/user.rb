class User < ApplicationRecord

  enum is_delete: {Available: false, Invalid: true}

  def active_for_authentication?
        super && (self.is_delete === "Available")
  end

  has_many :posts, dependent: :destroy
  attachment :image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
