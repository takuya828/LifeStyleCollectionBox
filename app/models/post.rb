class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  def self.sort(selection)
    case selection
    when 'new'
      all.order(created_at: :DESC)
    when 'old'
      all.order(created_at: :ASC)
    when 'favorites'
      find(Favorite.group(:post_id).order(Arel.sql('count(post_id) desc')).pluck(:post_id))
    end
  end

  belongs_to :user
  belongs_to :category
  attachment :image
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
