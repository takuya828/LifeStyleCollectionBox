class Post < ApplicationRecord

  def self.sort(selection)
    case selection
    when 'new'
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
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
