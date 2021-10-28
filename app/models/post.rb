class Post < ApplicationRecord
   belongs_to :user
   belongs_to :category
   attachment :image
   has_many :post_comments, dependent: :destroy
   has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
